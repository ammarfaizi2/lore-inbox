Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264760AbSJ3SJH>; Wed, 30 Oct 2002 13:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264764AbSJ3SJH>; Wed, 30 Oct 2002 13:09:07 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:4498 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S264760AbSJ3SJG>;
	Wed, 30 Oct 2002 13:09:06 -0500
Date: Wed, 30 Oct 2002 10:15:18 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: merlin <merlin@merlin.org>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at drivers/scsi/scsi_lib.c:819 with 2.5.44-ac5
Message-ID: <20021030101518.A13081@eng2.beaverton.ibm.com>
Mail-Followup-To: merlin <merlin@merlin.org>, Jens Axboe <axboe@suse.de>,
	linux-kernel@vger.kernel.org
References: <20021030143502.GK3416@suse.de> <20021030154359.1C107868F0@primary.mx.nitric.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20021030154359.1C107868F0@primary.mx.nitric.com>; from merlin@merlin.org on Wed, Oct 30, 2002 at 10:43:59AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 10:43:59AM -0500, merlin wrote:
> r/axboe@suse.de/2002.10.30/15:35:02
> >On Wed, Oct 30 2002, merlin hughes wrote:

> >> Oct 28 12:36:09 badb kernel: Incorrect number of segments after building lis
> >t
> >> Oct 28 12:36:09 badb kernel: counted 2, received 1
> >> Oct 28 12:36:09 badb kernel: req nr_sec 8, cur_nr_sec 8
> >
> >Please try 2.5.44-BK and see if that works, James fixed this one.
> 
> If that's equivalent to 2.5.44 +
> http://www.kernel.org/pub/linux/kernel/people/dwmw2/bk-2.5/cset-1.808-to-1.869.txt.gz
> then I get the same error (incorrect number of segments...). It happened
> earlier in the boot process so I couldn't catch the details; it looked
> like it oopsed along with everything else.
> 
> Thanks, Merlin

Merlin -

This looks the same as the problem Badari and I have hit with the qla running
with mm patches, check Badari's latest message on linux-scsi:

http://marc.theaimsgroup.com/?l=linux-scsi&m=103599960611881&w=2

We are getting:

Incorrect number of segments after building list
counted 3, received 2
req nr_sec 256, cur_nr_sec 8

-- Patrick Mansfield
