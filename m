Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293531AbSCLLXU>; Tue, 12 Mar 2002 06:23:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310284AbSCLLXK>; Tue, 12 Mar 2002 06:23:10 -0500
Received: from dsl-213-023-043-170.arcor-ip.net ([213.23.43.170]:34452 "EHLO
	starship") by vger.kernel.org with ESMTP id <S293531AbSCLLW7>;
	Tue, 12 Mar 2002 06:22:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [CFT] delayed allocation and multipage I/O patches for 2.5.6.
Date: Tue, 12 Mar 2002 12:18:01 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <3C8D9999.83F991DB@zip.com.au>
In-Reply-To: <3C8D9999.83F991DB@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16kkID-0001qr-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On March 12, 2002 07:00 am, Andrew Morton wrote:
>   Identifies readahead thrashing.
> 
>     Currently, it just performs a shrink on the readahead window when thrashing
>     occurs.  This greatly reduces the amount of pointless I/O which we perform,
>     and will reduce the CPU load.  The idea is that the readahead window
>     dynamically adjusts to a sustainable size.  It improves things, but not
>     hugely, experimentally.

The question is, does it wipe out a nasty corner case?  If so then the improvement
for the averge case is just a nice fringe benefit.  A carefully constructed test
that triggers the corner case would be most interesting.

-- 
Daniel
