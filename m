Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSHRMSL>; Sun, 18 Aug 2002 08:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSHRMSL>; Sun, 18 Aug 2002 08:18:11 -0400
Received: from adsl-161-92.barak.net.il ([62.90.161.92]:13069 "EHLO
	hirame.qlusters.com") by vger.kernel.org with ESMTP
	id <S314529AbSHRMSK>; Sun, 18 Aug 2002 08:18:10 -0400
Subject: Re: Alloc and lock down large amounts of memory
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Gilad Ben-yossef <gilad@benyossef.com>
Cc: Bhavana Nagendra <Bhavana.Nagendra@3dlabs.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1029672587.12504.88.camel@sake>
References: <23B25974812ED411B48200D0B774071701248520@exchusa03.intense3d.com> 
	<1029672587.12504.88.camel@sake>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 15:19:29 +0300
Message-Id: <1029673169.12593.93.camel@sake>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-18 at 15:09, Gilad Ben-Yossef wrote:

> > 4. When a process exits will it cause a close to occur on the device?
> 
> Depends how you got the shared memeory. With mmap() it's yes (for
> regular files at least), with shmget/shmat it's no by default. For mmap
> of non regulat files (e.g. device files) anything the device file writer
> had in mind is the answer.
> 
> man shmget, shmat, shmat and finally mmap will help you a lot.

When I first read the question I was still thinking in terms of shared
memeory and thought you meant: 'will it destroy the shared memory
segment?'. 

If the question was not related to shared memeory and you meant 'will it
do the same as close() on the file' the answer is yes as well unless the
device driver specifically chose to fail that for some reason (see the
watchdog devices for an example and a reason).

Gilad.


-- 
Gilad Ben-Yossef <gilad@benyossef.com>
Code mangler, senior coffee drinker and VP SIGSEGV
Qlusters ltd.

"You got an EMP device in the server room? That is so cool."
      -- from a hackers-il thread on paranoia



