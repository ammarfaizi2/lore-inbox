Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291114AbSBGFMl>; Thu, 7 Feb 2002 00:12:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291110AbSBGFMd>; Thu, 7 Feb 2002 00:12:33 -0500
Received: from smtp01.web.de ([194.45.170.210]:13075 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id <S291114AbSBGFMR>;
	Thu, 7 Feb 2002 00:12:17 -0500
Message-ID: <3C620B28.6010902@web.de>
Date: Thu, 07 Feb 2002 06:05:44 +0100
From: Todor Todorov <ttodorov@web.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20020104
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Drew P. Vogel" <dvogel@intercarve.net>
CC: "J.S.S" <jss@pacbell.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel reboot problem
In-Reply-To: <Pine.LNX.4.33.0202062344120.32081-100000@northface.intercarve.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Drew P. Vogel wrote:

>What does the initrd= line do, and how does initrd-2.4.17-10.img get in
>/boot?
>
It's a compressed file containing the compiled modules which is needed 
if a driver should be initialized before mounting the root file system, 
eg a driver for the root system. As it is in the 2.4.7 image section it 
refers only to the 2.4.7 kernel and not 2.4.18 (or whatever he tries to 
compile).

And speaking of it - J.S.S., did you take the options from the Red Hat's 
stock kernel as an example to choose your options? (From your mail I 
recon that this is one of your first attempts to compile an own kernel, 
am I correct?) If you did that, you rpobably included the fs driver for 
your root system as a module and not hardlinked in the kernel - just as 
Red Hat does? In such case you would need either to provide an initrd 
image too (`man initrd`), or recompile your kernel with the driver for 
the root filesystem ( ext2 or/and ext3 or reiserfs, don't know how you 
formated your linux partition(s) ) with <y> as option for it instead of 
<m>.....

Stupid me for not suggesting to check that in the first mail :-/

Hope you will locate the error quickliy.

Cheers 

-- 

Todor Todorov           <ttodorov@web.de>
Networkadministration   <todor.todorov@skr-skr.de>
SKR GmbH & Co. KG       http://www.skr-skr.de

-----------------
"Only two things are infinite, the universe and the
 human stupidity, and I'm not sure about the former"
                               - Einstein



