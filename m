Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317176AbSF1W4A>; Fri, 28 Jun 2002 18:56:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317180AbSF1Wz7>; Fri, 28 Jun 2002 18:55:59 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:56207 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317176AbSF1Wz7>; Fri, 28 Jun 2002 18:55:59 -0400
Date: Fri, 28 Jun 2002 23:59:42 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020628215942.GA3679@pelks01.extern.uni-tuebingen.de>
Mail-Followup-To: Andrew Morton <akpm@zip.com.au>,
	LKML <linux-kernel@vger.kernel.org>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D18A273.284F8EDD@zip.com.au>
User-Agent: Mutt/1.4i
From: Daniel Kobras <kobras@tat.physik.uni-tuebingen.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2002 at 10:03:47AM -0700, Andrew Morton wrote:
> If it's because of the disk-spins-up-too-much problem then
> that can be addressed by allowing the commit interval to be
> set to larger values.

The updated commit interval will only affect new transactions, correct?
In other words, when changing the commit interval from t_old to t_new,
it will take t_old seconds until we can be certain there are only
transactions with a t_new expiry interval in the queue?  Or is there a
way to flush the current queue of transactions, eg. by fsync()ing the
underlying block device, or by sending a magic signal to kjournald?  If
such manual interaction is possible, it'd also be handy to have the
opposite: a be-anal mode (eg. if commit interval==0) meaning 'do not
write any transaction to disk until explicitly told to'.  This parallels
the way kupdated can be tuned for traditional write-back.

Regards,

Daniel.

