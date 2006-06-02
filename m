Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030268AbWFBVA3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030268AbWFBVA3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 17:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030260AbWFBVA2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 17:00:28 -0400
Received: from warden-p.diginsite.com ([208.29.163.248]:6301 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP
	id S1030268AbWFBVA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 17:00:26 -0400
Date: Fri, 2 Jun 2006 11:49:32 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Pavel Machek <pavel@ucw.cz>
cc: Ondrej Zajicek <santiago@mail.cz>,
       "Antonino A. Daplas" <adaplas@gmail.com>,
       Jon Smirl <jonsmirl@gmail.com>, Dave Airlie <airlied@gmail.com>,
       "D. Hazelton" <dhazelton@enter.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
In-Reply-To: <20060602085832.GA25806@elf.ucw.cz>
Message-ID: <Pine.LNX.4.63.0606021146320.4686@qynat.qvtvafvgr.pbz>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> 
 <200605272245.22320.dhazelton@enter.net>  <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>
  <200605280112.01639.dhazelton@enter.net>  <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com>
  <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> 
 <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz>  <447CBEC5.1080602@gmail.com>
 <20060602083604.GA2480@localhost.localdomain> <20060602085832.GA25806@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Jun 2006, Pavel Machek wrote:

>> I just implemented text mode switch and tileblit ops into viafb
>> (http://davesdomain.org.uk/viafb/index.php) and it is about four
>> times faster than accelerated graphics mode and about eight times
>> faster than unaccelerated graphics mode (both measured using cat
>> largefile with ypan disabled). So textmode is meaningful
>> alternative.
>
> I mean.... it is displaying text faster than refresh rate... so who
> cares?
>
> You can only *display* so much text a second (and then, user is only
> able to see *much* less text) and both text mode and frame buffers are
> way past that limits. so.... who cares?

there are quite a few times when you have text output that you need to 
scroll through, but you really don't need to read it as it goes by.

for example, accidently cating a large file, running a program with overly 
verbose debugging output, etc.

yes, if you never make mistakes and know that these are problem cases 
ahead of time you can redirect the output. but in the real world sysadmins 
really do notice when they are on a console that is slower.

if reading speed was the limiting factor very few people would need 
anything faster then a 9600 baud terminal.

David Lang
