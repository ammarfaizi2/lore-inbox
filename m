Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUECSMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUECSMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 14:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263820AbUECSKY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 14:10:24 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:52671 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S263826AbUECSKC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 14:10:02 -0400
Message-ID: <40968A9F.6070608@keyaccess.nl>
Date: Mon, 03 May 2004 20:08:31 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040117
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] removal of legacy cdrom drivers (Re: [PATCH] mcdx.c insanity
 removal)
References: <20040502024637.GV17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405011953140.18014@ppc970.osdl.org> <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk> <4095BAA3.3050000@keyaccess.nl> <20040503055934.GA17014@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040503055934.GA17014@parcelfarce.linux.theplanet.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@parcelfarce.linux.theplanet.co.uk wrote:

> OK...  So we have
> 	* potentially faulty mcdx (2.4, apparently either driver corrupts
> memory in some conditions or isofs does the same for some IO failures -
> need to take a look at that report more carefully).
> 	* cdu31a (FUBAR driver, nasty to fix, "most of the time" works on
> 2.6)
> 	* sbpcd (at least two, both untested with 2.6)

Okay, with a trivial hack to have the thing initialise when builtin, 
sbpcd does pretend to work:

3y25:~$ uname -r
2.6.5
3y25:~$ mount | grep cdrom
/dev/sbpcd on /mnt/cdrom type iso9660 (ro,noexec,nosuid,nodev)
3y25:~$ ls /mnt/cdrom/
cd.id*        install.exe*  lecdemos/     readme.doc*   resource/ 
support/

However, any "cp" from cd-rom oopses the box.

> Is anybody willing to fix those drivers?

I was actually planning to get around to that at some point. Somewhat 
fond of this drive. As you say, driver is a disaster area; a few trivial 
fixes are not what it wants and at this point, fixing it properly would 
not be a trivial undertaking for me. Am also currently very busy 
elsewhere. Could it be kept around a bit?

Rene.
