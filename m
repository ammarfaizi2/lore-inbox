Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130897AbRBPTC0>; Fri, 16 Feb 2001 14:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130821AbRBPTCQ>; Fri, 16 Feb 2001 14:02:16 -0500
Received: from mail.valinux.com ([198.186.202.175]:6404 "EHLO mail.valinux.com")
	by vger.kernel.org with ESMTP id <S130897AbRBPTB0>;
	Fri, 16 Feb 2001 14:01:26 -0500
Message-ID: <3A8D7904.94C477F2@valinux.com>
Date: Fri, 16 Feb 2001 11:01:24 -0800
From: Samuel Flory <sflory@valinux.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.18pre11-va1.7smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Tigran Aivazian <tigran@veritas.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: mke2fs and kernel VM issues
In-Reply-To: <Pine.LNX.4.21.0102161058580.2099-100000@penguin.homenet>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian wrote:
> 
> On Thu, 15 Feb 2001, Samuel Flory wrote:
> 
> >   What is believed to be the current status of the typical mke2fs
> > crashes/hangs due to vm issues?  I can reliably reproduce the issue on a
> > heavily modifed VA kernel based on 2.2.18.  Is there a kernel which is
> > believed to be a known good kernel?  (both 2.2.x and 2.4.x)
> 
> I can mke2fs (successfully) on a 270G block device. Yes, of course, I also
> get various page allocation failures while this happens but they are not
> deadly, i.e. the thing (our volume manager) just retries until it works
> and after a while I have a valid (and a very big) ext2 filesystem with 0
> processes killed.
> 
> The kernel I use is 2.4.2-pre3. The machine has 6G RAM with the 3G given
> to kernel virtual. The amount of swap is massive (2G) but it is never
> used.

  I've never been able reliably reproduce any sort of mke2fs hang on
systems with more than 512M of RAM.  It would be interesting to know if
other people are seeing this under SW-RAID, and other controllers. 
(Currently everyone in direct contact with me uses a Mylex controller.) 
The key seems to be 512 or smaller amounts of RAM, and a 80G or larger
logical drive.

-- 
Solving people's computer problems always
requires more hardware be given to you.
(The Second Rule of Hardware Acquisition)
Samuel J. Flory  <sam@valinux.com>
