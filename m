Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263498AbTJBV5B (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 17:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263509AbTJBV5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 17:57:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9353 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263498AbTJBV45
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 17:56:57 -0400
Message-ID: <3F7C9F15.5000602@pobox.com>
Date: Thu, 02 Oct 2003 17:56:37 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Erik Steffl <steffl@bigfoot.com>
CC: Martin List-Petersen <martin@list-petersen.se>,
       Andrew Marold <andrew.marold@wlm.edial.com>,
       linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Bernhard Rosenkraenzer <bero@arklinux.org>
Subject: Re: Serial ATA on Dell Dimension 8300 (Was: Re: Serial ATA support
 in	2.4.22)
References: <C67EF1F46A97534FADC870220F3AC8B79D4FDD@exchange.edial.office>	 <3F7AEF15.1070301@pobox.com>  <3F7B0209.7070509@pobox.com> <1065130970.5842.193.camel@loke> <3F7C9E1F.2020709@bigfoot.com>
In-Reply-To: <3F7C9E1F.2020709@bigfoot.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Steffl wrote:
> Martin List-Petersen wrote:
> 
>> I've got trouble with both 2.4.22-ac1, ac4 and 2.4.22-bk25 + newest sata
>> patch. (Debian Sid)
>>
>> When i try to boot ac1 or ac4 from harddisk. The kernel would fail by
>> endless stating:
>> kmod: failed to exec /sbin/modprobe -s -k binfmt-0000, errno = 8
>> on screen.
>>
>> Do i boot the same kernel from floppy or cd (syslinux/isolinux - dmesg 
>> for ac4 attached, bootet from cd) it boots without trouble, mounts the 
>> harddisk etc.
>>
>> The machine is a Dell Dimension 8300 (practically the same as the 
>> Precision 360), with Intel 875 chipset (ICH5 SATA controllers).
>> In bk25+sata patch reiserfs seems to be broken (dmesg attached), i 
>> will try an older version tomorrow.
>>
>> I simply can't figure out, whats wrong here.
> 
> 
>   I have intel D865PERL mb (close but not same as you have, I think they 
> have the same sata controller), I used the 2.4.21-ac4 kernel, with 
> SCSI_ATA enabled (otherwise system freezes right after it detects HDs). 
> I also had to use libata5 patches from Jeff Garzik  to be able to use 
> drive >137GB (not sure whether libata5 are in one of the more recent 
> kernels or ac patches).


Basically I need to get off my butt and send Alan and Bero some updates...

Latest patches against mainline (2.4.22-bkXX and 2.6.0-testX-bkXX) are 
always posted at 
ftp://ftp.kernel.org/pub/linux/kernel/people/jgarzik/libata/  and the 
latest Fedora Core (what used to be Red Hat Linux) supports it out of 
the box as well.

It does take a bit of potentially non-trivial hand merging to patch 
successfully into -ac tree... :(

	Jeff



