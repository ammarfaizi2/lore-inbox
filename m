Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288801AbSBUHFL>; Thu, 21 Feb 2002 02:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292317AbSBUHFB>; Thu, 21 Feb 2002 02:05:01 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:30010 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S288801AbSBUHEy>; Thu, 21 Feb 2002 02:04:54 -0500
Date: Thu, 21 Feb 2002 02:04:49 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] size-in-bytes
Message-ID: <20020221020449.B8733@redhat.com>
In-Reply-To: <UTC200202161609.QAA31164.aeb@cwi.nl> <E16cwVW-0000jf-00@starship.berlin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E16cwVW-0000jf-00@starship.berlin>; from phillips@bonn-fries.net on Mon, Feb 18, 2002 at 11:43:38PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2002 at 11:43:38PM +0100, Daniel Phillips wrote:
> We want to stay with the shift counts.  They should be the primary currency
> of size measurement.  You can add shift counts together and get nice, compact
> code, whereas with absolute size you often have to ugly things - e.g., it's a
> pain to divide by blocksize when you have it as an absolute number, it's easy
> when you have it as a shift.
> 
> If you are going to the trouble of fixing this, please don't use absolute
> size as the primary measure, use a shift count.

Most of this is targetted at userland which needs byte counts (size in 
sectors was a bug introduced after the original BLKGETSIZE64 went in).  
Using the number of sectors in kernel is perhaps more efficient, but it 
is a microoptimization that won't show up on any benchmarks.

		-ben
