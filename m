Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbULCKgH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbULCKgH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 05:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbULCKgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 05:36:07 -0500
Received: from [213.146.154.40] ([213.146.154.40]:64680 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262143AbULCKgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 05:36:03 -0500
Date: Fri, 3 Dec 2004 10:35:45 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Stefan Schmidt <zaphodb@zaphods.net>, xhejtman@mail.muni.cz,
       marcelo.tosatti@cyclades.com, piggin@cyberone.com.au,
       linux-kernel@vger.kernel.org, linux-xfs@oss.sgi.com
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041203103545.GC10799@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Stefan Schmidt <zaphodb@zaphods.net>,
	xhejtman@mail.muni.cz, marcelo.tosatti@cyclades.com,
	piggin@cyberone.com.au, linux-kernel@vger.kernel.org,
	linux-xfs@oss.sgi.com
References: <20041113144743.GL20754@zaphods.net> <20041116093311.GD11482@logos.cnet> <20041116170527.GA3525@mail.muni.cz> <20041121014350.GJ4999@zaphods.net> <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz> <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202145610.49e27b49.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 02:56:10PM -0800, Andrew Morton wrote:
> hm, OK, interesting.
> 
> It's quite possible that XFS is performing rather too many GFP_ATOMIC
> allocations and is depleting the page reserves.  Although increasing
> /proc/sys/vm/min_free_kbytes should help there.

There's only a single place in XFS (and a second one for debug builds) doing
GFP_ATOMIC allocations.

