Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319067AbSIJHlv>; Tue, 10 Sep 2002 03:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319068AbSIJHlv>; Tue, 10 Sep 2002 03:41:51 -0400
Received: from packet.digeo.com ([12.110.80.53]:2788 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S319067AbSIJHlu>;
	Tue, 10 Sep 2002 03:41:50 -0400
Message-ID: <3D7DA6E0.4F9B3068@digeo.com>
Date: Tue, 10 Sep 2002 01:01:36 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
CC: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@zip.com.au>,
       Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: One more bio for for floppy users in 2.5.33..
References: <3D77A58F.B35779A1@zip.com.au> <Pine.LNX.4.33.0209051155091.1307-100000@penguin.transmeta.com> <20020910092545.A21776@bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2002 07:46:27.0975 (UTC) FILETIME=[2B9F9170:01C2589E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
> ...
> 
> Ehmm. I'm in the data-recovery business, and we seem to have lost
> the ability to recover the other 3k of a 4k page if one of the blocks
> is bad.
>
> And we're annoyed about the read-ahead trying to read blocks past
> a bad block without returning to the application.
> 

You can use the raw driver, or O_DIRECT against /dev/hdXX.  That
will give 512-byte granularity and no readahead.
