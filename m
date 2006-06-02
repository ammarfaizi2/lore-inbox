Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWFBMSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWFBMSU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWFBMSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:18:20 -0400
Received: from wr-out-0506.google.com ([64.233.184.234]:49208 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751282AbWFBMST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:18:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=UwBa1yfzxlQghiUx1qq9psmw9AOlBUbt7Bf3nNtaku/PcczO/P4javwV88ad1N2FPQj2h7Y5lpWLR3motclyj7AzMXSJiJmmFlfTJaov9U5/JZV3/zjUocKyvBPW0y7jR8l69XDIKbEECJ7zJknQYmQWugocsFVrvq5AYOjccY4=
Message-ID: <44802C6C.6030606@gmail.com>
Date: Fri, 02 Jun 2006 20:17:48 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Ondrej Zajicek <santiago@mail.cz>
CC: David Lang <dlang@digitalinsight.com>, Jon Smirl <jonsmirl@gmail.com>,
       Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <200605272245.22320.dhazelton@enter.net> <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com> <200605280112.01639.dhazelton@enter.net> <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <447CBEC5.1080602@gmail.com> <20060602083604.GA2480@localhost.localdomain>
In-Reply-To: <20060602083604.GA2480@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ondrej Zajicek wrote:
> On Wed, May 31, 2006 at 05:53:09AM +0800, Antonino A. Daplas wrote:
>> David Lang wrote:
>>> On Sun, 28 May 2006, Jon Smirl wrote:
>> So even a dumb driver such as vesafb that has to do on the fly
>> color conversions while pushing 64x more data to the bus can be
>> faster than vgacon.
> 
> I just implemented text mode switch and tileblit ops into viafb
> (http://davesdomain.org.uk/viafb/index.php) and it is about four
> times faster than accelerated graphics mode and about eight times
> faster than unaccelerated graphics mode (both measured using cat
> largefile with ypan disabled).

Never said that framebuffer can ever be faster than text mode, the
comparison was made against vgacon only. The reason why vgacon is
slow is because the screen buffer of vgacon is the actual VGA RAM.
So all operations (copies, fills, blits) are done in io memory.
And access to graphics memory is always slow, especially reads.

> So textmode is meaningful
> alternative.

This point was never questioned.

Tony
 

