Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317298AbSFCHfj>; Mon, 3 Jun 2002 03:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317299AbSFCHfi>; Mon, 3 Jun 2002 03:35:38 -0400
Received: from daimi.au.dk ([130.225.16.1]:3421 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317298AbSFCHfi>;
	Mon, 3 Jun 2002 03:35:38 -0400
Message-ID: <3CFB1C42.A03ACABC@daimi.au.dk>
Date: Mon, 03 Jun 2002 09:35:30 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID-6 support in kernel?
In-Reply-To: <Pine.LNX.4.33.0206030044270.27651-100000@mail.pronto.tv>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Sigurd Karlsbakk wrote:
> 
> hi all
> 
> I'n working on server setup with some 16 disks in RAID-5; one of them a
> spare. After a little reading, I find myself longing for support for
> RAID-6 support in kernel, giving the opportunity to allow for two failed
> drives without a chrash (see links about RAID-6 below if interested).
> 
> I am aware of that not all kernel hackers like such configurations, and
> that some will rather see small RAID-configurations connected with VLM.
> I beleive there is a reason for using RAID-6, and RAID-controller vendors
> (such as Compaq) are already using them, so why shouldn't linux do so
> also? With a high number of cheap IDE drives, the chance of one failing is
> quite high, so why not RAID-6? At least for a system doing most reads...
> 
> thanks
> 
> roy
> 
> RAID-6 layout: http://www.acnc.com/04_01_06.html

If it is supposed to survive two arbitrary disk failures something is
wrong with that figure. They store 12 logical sectors in 20 physical
sectors across 4 drives. With two lost disks there are 10 physical
sectors left from which we want to reconstruct 12 logical sectors.
That is impossible.

OTOH it is possible to construct a system with optimal capacity and
ability to survive any chosen number of disk failures. This can be
done using either a Reed-Soloman code or Lagrange interpolation of
polynomials over a finite field.

However I guess those techniques would be inefficient in software.

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
