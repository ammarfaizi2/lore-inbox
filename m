Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263722AbTFHTav (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jun 2003 15:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbTFHTav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jun 2003 15:30:51 -0400
Received: from kilmainham.stdlib.net ([65.214.160.134]:42505 "EHLO kilmainham")
	by vger.kernel.org with ESMTP id S263722AbTFHTap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jun 2003 15:30:45 -0400
Date: Sun, 8 Jun 2003 20:44:22 +0100
From: Colm =?iso-8859-15?Q?MacC=E1rthaigh?= <colm@stdlib.net>
To: Andrew Miklas <public@mikl.as>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linksys WRT54G and the GPL
Message-ID: <20030608194421.GA92559@kilmainham.stdlib.net>
References: <200306072241.23725.public@mikl.as>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200306072241.23725.public@mikl.as>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[general note: please cc, I'm not on lkml]

Andrew,

I was involved in a similar such action with Dell, though I had somewhat
different approach, but nevertheless I'm going to recount my experiences
as it may be useful for the purposes of comparison. Others: mark as read
now if you don't like long mails.

Early in the year, I purchased a nice new Dell Laptop, for running Linux
on, of course. Since it saved me money, I bought a Dell TrueMobile 1184
Access Point/Router at the same time.

 http://tinyurl.com/ds6i (accessories.us.dell.com)

 http://tinyurl.com/ds6d (support.ap.dell.com)

Give an impression of the product. Being a Network Engineer, I felt
compelled to fingerprint the device, very quickly finding that it
ran telnet on port 333, and after loging in (using the root username,
and the admin password), found that it was running armlinux:

# cat /proc/version

Linux version 2.2.14-v1.9 (root@localhost.localdomain) (gcc version
2.9-vLinux-armtool-0523) #5357 Sat Jan 25 17:39:42 CST 2003

# cat /proc/cpuinfo   
Processor       : S3C4510/SEC arm7tdmi rev 0
BogoMips        : 44.24
Hardware        : <NULL>

Other GPL software was abundant, including ipchains, busybox .. and
other things you would expect. Running Linux of course pleased me,
because it meant I put it to some real use (currently it's also
my house print server for example) as I had a self-built router
I wasnt going to stop using (I mean how could anyone live without
IPv6?). 

After some discussion on ILUG (www.linux.ie), I researched it further,
I double-checked, and none of the documentation Dell sent me, nor the
software CD, nor the website indicated it was using GPL software, and
did provide me with a copy of the license, or a written offer with a
means to obtain the source. I'm not a licensing hack, and I almost
would have been prepared to just leave it be had the Documentation not
said:

"Requirements:
  
  You must have at least one computer that has the following: 

   1. Running Microsoft(R) Windows(R) 98, 98SE, Windows Me,
      Windows 2000, Windows XP Home or XP Professional (
      Windows 2000 or XP require you to have administrator
      privileges on your computer in order to configure the
      router - see the computers users' guide for more information)
   2. A CD drive
   3. An active Internet connection"

Which supremely annoyed me, as of course all you need is *any* 
IP capable system for the router to work, it just uses plain NAT,
nothing Windows specific, and you can use any browser to configure
it's luser interface. So after some grepping:

# cat /etc/hosts
127.0.0.1               vLinux/Vitals_System_Inc.
  
They appear to have a website at:
  
  http://www.vitalsystem.com/

Though

  http://www.onsoftwarei.com/
  
seem to be the people who license support vlinux:

  http://www.onsoftwarei.com/product/prod_vlinux.htm

I'm sure there are people on-list with much more in-depth knowlege of
these companies.

Anyway, since in my case, Dell were the direct vendor, I contacted them
first. After some number chasing, I was passed to Dell Ireland's Legal
Director, who got on to the Dell US guys. 

I have to say that allthough it took some time for the issue to be
resolved, Dell were abosulutely brilliant about it, and kept me
informed, they were extremely friendly and helpful about the request.

The original mail I sent Dell is available at:

 http://www.redbrick.dcu.ie/~colmmacc/TrueMobile-1184/dell.letter

But after that, most of the action happened on phone. 6 weeks
later, Seamus (Dell Legal) was able to respond positively to my
request, and I got a CD including the source free of Charge, and
a nice letter:

 http://www.redbrick.dcu.ie/~colmmacc/TrueMobile-1184/dell.jpg

The contents are available online, and if anyone wants it, mails
me and I'll give you the URL, but to save me bandwidth - it's
vanilla Linux 2.2.14 with the 2.2.14-rmk4 patch, nothing bespoke.
But now that I had the configuration, I could actually build 
a replacement IPv6 capable kernel. 

Dell have also reviewed their procedures to ensure that this kind
of thing does not happen again, and from talking to Dell Legal I
got the impression that it was the result of suppliers not fully
informing Dell about Licensing provisions. 

Dell now ship a copy of the source and the license on the CD that
comes with the TrueMobile kit. I really have to make clear here,
Dell did amazingly well, they researched it, kept me informed,
responded positively, and rectified procedures. It's a great example
of how to do it right. 

So, I don't know what the linksys situation is fully, but I do hope
that this report may help you in that it gives an example of a
near-identical situation having been resolved successfully in the past.

I also know from Dell Legal, that my request generated a lot of 
e-mail internal to Dell legal, so I'm sure they researched it very
well. If Dell Legal come to the conclusion that this is what they
must do, that certainly might be a useful example to point Linksys
at.

On Sat, Jun 07, 2003 at 10:41:23PM -0400, Andrew Miklas wrote:
> Sorry for the very lengthly posting, but I want to be as precise as possible 
> in describing this problem.
> 
> Awhile ago, I mentioned that the Linksys WRT54G wireless access point used 
> several GPL projects in its firmware, but did not seem to have any of the 
> source available, or acknowledge the use of the GPLed software.  Four weeks 
> ago, I spoke with an employee at Linksys who confirmed that the system did 
> use Linux, and also mentioned that he would work with his management to 
> ensure that the source was released.  Unfortunately, my e-mails to this 
> individual over the past three weeks have gone unanswered.  Of course, I also 
> tried contacting Linksys through their common public e-mail accounts 
> (pr@linksys.com, mailroom@linksys.com) to no avail.
> 
> However, it is hard for me to know if my contact in the company has just gone 
> on a three week vacation (and not set an auto-responder), or has been asked 
> to not answer anymore mail on this subject.  Also, I should note that I don't 
> own this product, so I can't determine if the source is shipped with it.  
> However, I have gone through all the available information on the Linksys 
> website, and can find no reference to the GPL, Linux (as it relates to this 
> product), or the firmware source code.  Also, the firmware binary (see below) 
> is freely available from their website.  There is no link from the download 
> page to the source, or any mention of Linux or the GPL.  Finally, it would be 
> strange if the source was included in the physical package, as my contact at 
> Linksys was initially unaware Linux was used in this product.
> 
> 
> 
> The following steps can be used to determine the exact nature of the possible 
> GPL violation.
> 
> 1. Go to the following URL:
>     http://www.linksys.com/download/firmware.asp?fwid=178
> 
> 2. Download the "firmware upgrade files":     
> ftp://ftp.linksys.com/pub/network/WRT54G_1.02.1_US_code.bin
>     (MD5SUM: b54475a81bc18462d3754f96c9c7cc0f)
> 
> 3. While it is downloading, confirm that there is nothing on the webpage to 
> indicate that this binary contains GPLed software.
> 
> 4. Once the download is complete, copy the contents of the file from offset 
> 0xC0020 onward into a new file.
>     dd if=WRT54G_1.02.1_US_code.bin of=test.dump skip=24577c bs=32c
> 
> 5. Notice that this file is an image of a CramFS filesystem.
>     Mount it.
> 
> 6. Explore the filesystem.  You will notice that the system appears to be 
> based on Linux 2.4.5.
>    Incidentally, there is at least one other GPLed project in the firmware: 
> the BusyBox userland component: (http://www.busybox.net/)
> 
> 7. The Linux kernel (I think) is mixed up with a bunch of other stuff in:
>     bin/boot.bin
> 
> 
> 
> You might want to know why I am interested in getting the code for the kernel 
> used in this device.
> 
> There's been some discussion here about Linux's lack of wireless support for a 
> few of the newer 802.11b and (nearly?) all 802.11g chips.  Incidentally, 
> Linux has excellent support for at least one manufacturer's wireless family.  
> The following Broadcom chips all appear to be supported under Linux -- if you 
> happen to be running Linux on a MIPS processor in a Linksys router:
> 
> Broadcom BCM4301 Wireless 802.11b Controller
> Broadcom BCM4307 Wireless 802.11b Controller
> Broadcom BCM4309 Wireless 802.11a Controller
> Broadcom BCM4309 Wireless 802.11b Controller
> Broadcom BCM4309 Wireless 802.11 Multiband Controller
> Broadcom BCM4310 Wireless 802.11b Controller
> Broadcom BCM4306 Wireless 802.11b/g Controller
> Broadcom BCM4306 Wireless 802.11a Controller
> Broadcom BCM4306 Wireless 802.11 Multiband Controller
> 
> This list was produced by running strings on:
> lib/modules/2.4.5/kernel/drivers/net/wl/wl.o
> 
> I am trying to determine exactly how tightly coupled these drivers are to the 
> kernel.
> 
> As an aside, I know that some wireless companies have been hesitant of 
> releasing open source drivers because they are worried their radios might be 
> pushed out of spec.  However, if the drivers are already written, would there 
> be any technical reason why they could not simply be recompiled for Intel 
> hardware, and released as binary-only modules?
> 
> 
> 
> Finally, I know that traditionally, Linux has allowed binary-only modules.  
> However, I was always under the impression that this required that the final 
> customer be allowed to remove them at will.  That is to say, you couldn't 
> choose to implement a portion of the kernel critical to the system's 
> operation in a module, and then not release that module under the GPL.  In 
> this particular case, I would argue that the wireless drivers are critical to 
> this device's operation (after all, it is a wireless access point).  In 
> addition, the final user in this case really can't just "rmmod" the wireless 
> driver.
> 
> The Broadcom driver, kernel, and really everything else in the firmware, are 
> (IMHO anyways) being used to form a discrete package -- the WRT54Gs firmware.  
> Does/should this have any implication on whether the Broadcom wireless module 
> must be covered by the GPL?
> 
> 
> 
> I would be very interested in knowing if I am mistaken in any of my claims or 
> conclusions, and if not, how I should proceed in getting this issue resolved.
> 
> 
> -- Andrew Miklas
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

-- 
Colm MacCárthaigh                        Public Key: colm+pgp@stdlib.net
colm@stdlib.net					  http://www.stdlib.net/
