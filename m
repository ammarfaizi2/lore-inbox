Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291248AbSBMB3F>; Tue, 12 Feb 2002 20:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291282AbSBMB2z>; Tue, 12 Feb 2002 20:28:55 -0500
Received: from holomorphy.com ([216.36.33.161]:59044 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S291248AbSBMB2h>;
	Tue, 12 Feb 2002 20:28:37 -0500
Date: Tue, 12 Feb 2002 17:28:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] get_request starvation fix
Message-ID: <20020213012809.GI767@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3C69A196.B7325DC2@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3C69A196.B7325DC2@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 12, 2002 at 03:13:26PM -0800, Andrew Morton wrote:
> Second version of this patch, incorporating Suparna's
> suggested simplification (the low-water mark was
> unnecessary).
> 
> This patch is working well here.  Hopefully it'll pop up
> in an rmap kernel soon.
> 
> Bill Irwin has been doing some fairly extensive tuning
> and testing of this.  Hopefully he'll come out with some
> numbers soon.

Much of my testing has involved varying elevator and bdflush parameters
to find what works best with this. From preliminary results it is clear
that the resolution of the fairness issues in this patch and the read
latency patch does not impair performance.

I'll do a bunch more runs tonight with the latest version of this.
My prior runs were with an earlier version.


Cheers,
Bill
