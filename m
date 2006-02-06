Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWBFUP1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWBFUP1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:15:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWBFUP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:15:27 -0500
Received: from dust.daper.net ([83.16.99.170]:5596 "EHLO daper.net")
	by vger.kernel.org with ESMTP id S932368AbWBFUP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:15:27 -0500
Date: Mon, 6 Feb 2006 21:15:23 +0100
From: Damian Pietras <daper@daper.net>
To: Peter Osterlund <petero2@telia.com>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
Message-ID: <20060206201523.GA9204@daper.net>
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com> <20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com> <m3ek39z09f.fsf@telia.com> <20060115210443.GA6096@daper.net> <m33bixaaav.fsf@telia.com> <20060205210746.GA16023@daper.net> <m3oe1l8ly9.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3oe1l8ly9.fsf@telia.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2006 at 11:44:46PM +0100, Peter Osterlund wrote:
> Damian Pietras <daper@daper.net> writes:
> 
> > Now I can mount CD-R, CD-RW, DVD+RW using pktcdvd.
> > 
> > Something strange happend when I copied files to DVD+RW und used eject.
> > After some time eject exitet, but the disc was stil in the burner, I was
> > allowed to open it by pressing the eject button, but then:
> > 
> > hda: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
> > hda: media error (bad sector): error=0x34 { AbortedCommand LastFailedSense=0x03
> 
> Thanks for testing. Please try this patch: It makes sure not to unlock
> the door if the disc is in use.

It still allows to eject the disc while `umount /media/cdrom0` is
waiting to finish.

-- 
Damian Pietras
