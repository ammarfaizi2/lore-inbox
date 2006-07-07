Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751152AbWGGCrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751152AbWGGCrb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 22:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbWGGCra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 22:47:30 -0400
Received: from pat.uio.no ([129.240.10.4]:8622 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751152AbWGGCra (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 22:47:30 -0400
Subject: Re: ext4 features
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Ric Wheeler <ric@emc.com>
Cc: Bill Davidsen <davidsen@tmr.com>, "J. Bruce Fields" <bfields@fieldses.org>,
       Theodore Tso <tytso@mit.edu>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44ADCA0C.90401@emc.com>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
	 <20060704010240.GD6317@thunk.org> <44ABAF7D.8010200@tmr.com>
	 <20060705125956.GA529@fieldses.org> <44AC2B56.8010703@tmr.com>
	 <20060705214133.GA28487@fieldses.org>  <44AC7647.2080005@tmr.com>
	 <1152189796.5689.17.camel@lade.trondhjem.org> <44ADC3CE.1030302@tmr.com>
	 <44ADCA0C.90401@emc.com>
Content-Type: text/plain
Date: Thu, 06 Jul 2006 22:46:59 -0400
Message-Id: <1152240419.6092.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.863, required 12,
	autolearn=disabled, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-06 at 22:42 -0400, Ric Wheeler wrote:

> The point of using checksums (or digital signatures on files) is to be 
> able to detect when the on disk file has been corrupted - not to look 
> for updates.  With normal disks, even writes that are flagged as correct 
> will occasionally actually end up corrupt on disk.  The rate that you 
> need to validate the checksums is not at a 4 time a day rate.
> 
> Buying a nice, high array can make this much less of a concern, but 
> those of us who get stuck using commodity disks should always have a way 
> of detecting corruption and a backup (either on tape or on another box).

I repeat: you do _not_ need high res ctime/mtime updates in order to
figure out whether or not you need to do a daily backup on your file.
You do need it in order to figure out if the page you just read in from
your NFS server 2 microseconds ago is still valid.

Cheers,
  Trond

