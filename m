Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWC0HLZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWC0HLZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 02:11:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWC0HLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 02:11:25 -0500
Received: from pproxy.gmail.com ([64.233.166.181]:58405 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750758AbWC0HLZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 02:11:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bjDCPI2ZWugoW65Ud1N8OD8UoDCuUTH0jIMTFB9u780yBwLhr7rdSobJoqq+9x1FmWLIQeVRMmiwk2P1cdHAe+J431YSZ091ufmyTL3lRKBPEWwt4/qlVIY6dt4egXmT+KliModmtmEKoPQoaQl3Jgo297dFE3yf40d9zrD7mmM=
Message-ID: <4427900C.7090506@gmail.com>
Date: Mon, 27 Mar 2006 15:11:08 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Herbert Poetzl <herbert@13thfloor.at>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: funny framebuffer fonts on PowerBook
 with radeonfb
References: <20060327004741.GA19187@MAIL.13thfloor.at>	 <1143422242.3589.2.camel@localhost.localdomain>	 <20060327033743.GA19788@MAIL.13thfloor.at> <1143437199.2221.3.camel@localhost.localdomain>
In-Reply-To: <1143437199.2221.3.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt wrote:
> On Mon, 2006-03-27 at 05:37 +0200, Herbert Poetzl wrote:
> Interesting... I suspect there is an endian bug in the new font code
> that hits odd sized fonts (or non-multiple-of-8 fonts). Can you try
> enabling 8x8 and 8x16 instead of 6x11 and 7x14 fonts and tell me if
> those work ?
> 
> Tony: If my suspition is confirmed, I think that's your call :)

It probably is, a remnant of the console rotation code.  If that is
truly the case, the patch I just sent in another thread should fix it.

Tony
