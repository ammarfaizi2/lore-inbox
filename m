Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261743AbVEJTMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbVEJTMY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 15:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbVEJTMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 15:12:24 -0400
Received: from rproxy.gmail.com ([64.233.170.205]:53775 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261743AbVEJTMV convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 15:12:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jCjXKfwpk0N05DsJGNKTJynBzk8J3z+Inui64ynYyLtpW1WdxGW+/YZAi0R4KXaHNdOFJUXDVsGU1C5NnhIglTWp9bAoB8tLzEr0ifFyYnG/LcsHrlXxL9W+/5IU/FvXtvV52MWe8qBsD60TEb8eZRnmEWs9ktJsoS7Yy5z8yHI=
Message-ID: <d120d50005051012126397d1a3@mail.gmail.com>
Date: Tue, 10 May 2005 14:12:21 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Mitch <Mitch@0bits.com>
Subject: Re: ALPS testers wanted (Was Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <d120d500050510112018b8a428@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4280F856.2080907@0Bits.COM>
	 <d120d500050510112018b8a428@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/05, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 5/10/05, Mitch <Mitch@0bits.com> wrote:
> > Still no go. Log attached.
> >
> 
> But I see a proper response (absolute packet) to the POLL command so
> we are maiking progress I think. It looks like the touchpad was left
> in disabled state somehow. Have you tried both the touchpad and
> trackpoint? Are both of them dead?
> 

Btw, does it help if you stick "ps2_command(&psmouse->ps2dev, NULL,
PSMOUSE_CMD_ENABLE)" at the end of alps_poll, just before "return rc"?
Another option is sticking it before second alps_passthrough_mode.

Unfortunately we don't have any ALPS programming notes so we have to
resort to trial-and-error way.

-- 
Dmitry
