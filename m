Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281266AbRKTSvY>; Tue, 20 Nov 2001 13:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281261AbRKTSu4>; Tue, 20 Nov 2001 13:50:56 -0500
Received: from [194.65.152.209] ([194.65.152.209]:37772 "EHLO
	criticalsoftware.com") by vger.kernel.org with ESMTP
	id <S281234AbRKTSuJ>; Tue, 20 Nov 2001 13:50:09 -0500
Message-Id: <200111201849.fAKInr205178@criticalsoftware.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: =?iso-8859-1?q?Lu=EDs=20Henriques?= 
	<lhenriques@criticalsoftware.com>
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: copy to suer space
Date: Tue, 20 Nov 2001 18:44:08 +0000
X-Mailer: KMail [version 1.3.1]
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <5.1.0.14.2.20011120165440.00a745b0@pop.cus.cam.ac.uk> <200111201714.fAKHEc276467@criticalsoftware.com> <20011120114124.T1308@lynx.no>
In-Reply-To: <20011120114124.T1308@lynx.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Maybe if you describe the actual problem that you are trying to solve, and
> not the actual way you are trying to solve it, there may be a better
> method. Usually, if something you are trying to do is very hard to do,
> there is a different (much better) way of doing it.
>
> Cheers, Andreas

OK, here it goes:

I'm developping a kernel module that needs to delay a process, that is, he 
receives a PID and, when a specific event occurs, that process shall be 
delayed. This delay shall be done in a way that the process keeps burning CPU 
time (it can not be, e.g., put in a waiting-list...).
The solution I found was to change its code segment, putting a loop in it. 
After a specified period of time, the original code must be restored and the 
process must keep going as nothing happened.
The main problem I found was already explained: can't write to the CS!

-- 
Luís Henriques
