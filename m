Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265580AbRF1HjC>; Thu, 28 Jun 2001 03:39:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265584AbRF1Hiw>; Thu, 28 Jun 2001 03:38:52 -0400
Received: from sportingbet.gw.dircon.net ([195.157.147.30]:50441 "HELO
	sysadmin.sportingbet.com") by vger.kernel.org with SMTP
	id <S265580AbRF1His>; Thu, 28 Jun 2001 03:38:48 -0400
Date: Thu, 28 Jun 2001 08:33:03 +0100
From: Sean Hunter <sean@dev.sportingbet.com>
To: Adam <adam@eax.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.2.x series and mm
Message-ID: <20010628083303.A27891@dev.sportingbet.com>
Mail-Followup-To: Sean Hunter <sean@dev.sportingbet.com>,
	Adam <adam@eax.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0106271008010.16671-100000@eax.student.umd.edu> <E15FI9n-0005Qz-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15FI9n-0005Qz-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jun 27, 2001 at 05:27:11PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2001 at 05:27:11PM +0100, Alan Cox wrote:
> > 	I'm fairly sure it is the file buffers as the apache is already
> > 	reniced to 20, it is got max 50 processes and each of processes is
> > 	limited to like 1.5mb of size via ulimit.
> 
> nice wont help you, it controls scheduling priority. Similar a ulimit just 
> ensures that no apache process goes mad and eats lots of memory (good idea
> but not helpful here). If your working set (and thats the bit the matters)
> really is exceeding memory by a fair bit then
> 
> a)	Add more RAM - that is the real optimal approach
> b)	Make the processes smaller (eg switch to thttpd from www.acme.com)
> c)	Speed up the I/O throughput relative to CPU speed
> 	- eg the 2.2 IDE UDMA patches

It may also be worth considering 

d)	Reduce the number of Apache processes so they fit nicely in RAM

Sean
