Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263944AbUDFS3T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263949AbUDFS3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:29:19 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:55307 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S263944AbUDFS3N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:29:13 -0400
Date: Tue, 6 Apr 2004 20:29:12 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Workaround for ReiserFS on root-filesystem
Message-ID: <20040406182912.GA13175@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <1I0Gz-63o-3@gated-at.bofh.it> <1I0Gz-63o-5@gated-at.bofh.it> <1I0Gz-63o-1@gated-at.bofh.it> <1I0Qg-6b0-5@gated-at.bofh.it> <c4ujgl$28qq$1@ulysses.news.tiscali.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ujgl$28qq$1@ulysses.news.tiscali.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ replied privately, but I repeat here]

On Mon, Apr 05, 2004 at 10:28:05PM +0200, Thomas Bach wrote:
> > It works for me here:
> >/dev/ide/host0/bus0/target0/lun0/part4 on / type reiserfs (rw,sync)
> >Linux mother 2.6.5 #10 Sun Apr 4 08:59:08 CEST 2004 i686 unknown unknown 
> >GNU/Linux
> >
> >It always worked - with 2.4.x, 2.5.x, 2.6.x up to 2.6.5.
> 
> OK! I am a bit confused. Could you perhaps pass me your /etc/fstab and 
> grub.conf/lilo.conf entrys?

 No problem. I'm using devfs, so I had to pass devfs names - the
standard ones as /dev/hda4 don't work.

My lilo conf:

image = /boot/kernel2_6
  root = /dev/discs/disc0/part4
  label = linux2_6fb
  append = "root=/dev/ide/host0/bus0/target0/lun0/part4"

and corresponding grub entry:

root (hd0,3)
title Linux_2.6
        kernel (hd0,0)/kernel2_6 acpi=force root=/dev/ide/host0/bus0/target0/lun0/part4 ro


And fstab:

/dev/ide/host0/bus0/target0/lun0/part4  /  reiserfs    defaults,sync   1       1

Greetings,
-- 
Tomasz Torcz                Only gods can safely risk perfection,     
zdzichu@irc.-nie.spam-.pl     it's a dangerous thing for a man.  -- Alia

