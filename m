Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030340AbWCUFt0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030340AbWCUFt0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 00:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWCUFtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 00:49:25 -0500
Received: from [81.222.97.19] ([81.222.97.19]:40419 "EHLO mail.terrhq.ru")
	by vger.kernel.org with ESMTP id S1030340AbWCUFtZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 00:49:25 -0500
From: Yaroslav Rastrigin <yarick@it-territory.ru>
Organization: IT-Territory 
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: VFAT: Can't create file named 'aux.h'?
Date: Tue, 21 Mar 2006 08:49:20 +0300
User-Agent: KMail/1.9
References: <1142890822.5007.18.camel@localhost.localdomain> <Pine.LNX.4.61.0603202244370.11933@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0603202244370.11933@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200603210849.20224.yarick@it-territory.ru>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
On 21 March 2006 00:46, you wrote:
> >	Hi everybody,
> >
> >while trying to back up a couple Linux directories to a FAT disk I ran
> >into a weird situation: I can't create a file called aux.h on the FAT
> >system! 
> >
> On DOS et al, there are a number of special filenames, such as
> 
> 	com1:
> 	com2: (and so on)
> 	lpt1:
> 	lpt2: (and so on)
> 	con:
> 	aux
> 	nul
> 
> (Try `dir >nul`, it's equivalent to unix's `ls -l >/dev/null` --
> aux is the auxiliary port, whatever that is)
> 
> It seems only fair to me to not allow creating these files under Linux 
> either, to avoid problems when booting back to Dos/Windows.
This is true. smbfs, OTOH, has no such checks, so creating aux.h on an smb share is one easy way to DoS 
all WinXP machines using(browsing) this share. Explorer hangs on reading directory with this file.
> 
> 
> Jan Engelhardt

-- 
Managing your Territory since the dawn of times ...
