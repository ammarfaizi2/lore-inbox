Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbTDHPRb (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261844AbTDHPRb (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:17:31 -0400
Received: from smtpzilla2.xs4all.nl ([194.109.127.138]:15631 "EHLO
	smtpzilla2.xs4all.nl") by vger.kernel.org with ESMTP
	id S261840AbTDHPR3 (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 11:17:29 -0400
Date: Tue, 8 Apr 2003 17:29:03 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
In-Reply-To: <b6s3tm$i2d$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.44.0304081536360.12110-100000@serv>
References: <200303311541.50200.pbadari@us.ibm.com> <Pine.LNX.4.44.0304031256550.5042-100000@serv>
 <20030403133725.GA14027@win.tue.nl> <Pine.LNX.4.44.0304031548090.12110-100000@serv>
 <b6s3tm$i2d$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7 Apr 2003, H. Peter Anvin wrote:

> I have an idea, why don't you read the archives of this mailing list
> for the past eight years and learn, once again, why dynamic numbers
> are broken for nearly all applications (disks and ptys being, perhaps,
> the few case where they actually work.)
> 
> This has been hashed and rehashed on this list so many times it's not
> even funny.

Ok, I checked the archives and found some interesting mails:

http://www.ussg.iu.edu/hypermail/linux/kernel/0105.1/1170.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0105.1/1180.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0105.1/1072.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0105.1/1310.html
http://www.ussg.iu.edu/hypermail/linux/kernel/0105.1/1348.html

This is from the last dev_t discussion I was able to find and my apologies 
to Linus for dragging him into this, personally I prefer a discussion 
based on arguments, but you want to feel the whip of authority. (There are 
also some juicy mails from Al, but you can look for these yourself.)

Linus argues here for dynamic numbers and I was not able to find a single 
mail, where he completely changed his mind since then. If you know 
something I don't, I'd be really happy to hear about it (actually I found 
9 (nine!) year old mails, where he argues for a more dynamic system).

In above discussion, Alan was one of the few who actually came up with
reasonable arguments, some of his concerns were:
- he needed a solution for 2.4:
  we are at 2.5 now and the kernel is mostly ready for dynamic device 
  numbers
- compatibility:
  it's trivial to preserve dev numbers below 0x10000, new drivers start 
  above this
- hardcoded ioctl knowledge:
  this is partly a compatibility problem and in the meantime it's 
  generally accepted that they are a bad idea most of the time and
  drivers should use e.g. sysfs instead.

Am I now worthy of an answer, so you could please explain "why dynamic 
numbers are broken for nearly all applications"? What were I supposed to 
learn from the archives? Maybe you should read them yourself, because 
I didn't found a single discussion with a clear outcome.

bye, Roman

