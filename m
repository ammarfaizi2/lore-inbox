Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261161AbVEKNqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVEKNqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 09:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261162AbVEKNqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 09:46:13 -0400
Received: from [80.227.59.61] ([80.227.59.61]:26343 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S261161AbVEKNqL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 09:46:11 -0400
Message-ID: <42820C76.3010008@0Bits.COM>
Date: Wed, 11 May 2005 17:45:26 +0400
From: Mitch <Mitch@0Bits.COM>
User-Agent: Mail/News Client 1.0+ (X11/20050509)
MIME-Version: 1.0
To: dmitry.torokhov@gmail.com, dtor_core@ameritech.net,
       linux-kernel@vger.kernel.org
Subject: Re: ALPS testers wanted (Was Re: [RFT/PATCH] KVMS, mouse losing sync
 and going crazy)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

Still no go. I added the line in and still hands after i leave it for a 
few seconds.

I'm out of town now till Monday 16th so won't be able to try any fixes 
till the unfortunately.

Cheers
Mitch

-------- Original Message --------
Subject: Re: ALPS testers wanted (Was Re: [RFT/PATCH] KVMS, mouse losing 
sync and going crazy)
Date: Tue, 10 May 2005 14:12:21 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Mitch <Mitch@0bits.com>
CC: linux-kernel@vger.kernel.org
References: <4280F856.2080907@0Bits.COM>	 
<d120d500050510112018b8a428@mail.gmail.com>

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

