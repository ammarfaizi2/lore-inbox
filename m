Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131071AbRCJRfk>; Sat, 10 Mar 2001 12:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131074AbRCJRfV>; Sat, 10 Mar 2001 12:35:21 -0500
Received: from islay.mach.uni-karlsruhe.de ([129.13.162.92]:43002 "EHLO
	mail.plan9.de") by vger.kernel.org with ESMTP id <S131071AbRCJRfL>;
	Sat, 10 Mar 2001 12:35:11 -0500
Date: Sat, 10 Mar 2001 18:34:18 +0100
From: Marc Lehmann <pcg@goof.com>
To: Igor Mozetic <igor.mozetic@uni-mb.si>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2 + aic7xxx still broken
Message-ID: <20010310183418.A5304@fuji.laendle>
Mail-Followup-To: Igor Mozetic <igor.mozetic@uni-mb.si>,
	linux-kernel@vger.kernel.org
In-Reply-To: <15004.63506.871707.827656@ravan.camtp.uni-mb.si>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15004.63506.871707.827656@ravan.camtp.uni-mb.si>; from igor.mozetic@uni-mb.si on Wed, Feb 28, 2001 at 02:07:30PM +0100
X-Operating-System: Linux version 2.4.2 (root@fuji) (gcc version 2.95.2.1 19991024 (release)) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2001 at 02:07:30PM +0100, Igor Mozetic <igor.mozetic@uni-mb.si> wrote:
> 2.4.2 + stock aic7xxx:
> ----------------------
> ...
> SCSI host 0 channel 0 reset (pid 0) timed out - trying harder

interestingly, I have exactly the same problems when booting my smp kernel
with either maxcpus=1, nosmp or the second cpu removed but NOT when the
kernel boots with two cpus (it works *perfectly*)

Unless macpus=! switches off apic (it doens't) this doesn't look like a
IRAQ problem, as the bios has no idea of the maxcpus=! option.

One thing that puzzles me is why the new driver looks for db_185.h in
/usr/include/db, which seems to be a rather nonstandard position for that
header (none my my slackware or home-grown boxes have that directory, all
of them have the db_185.h file in /usr/include, which is the standard
location I'd think since glibc-2.1 installed it there).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@goof.com      |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
