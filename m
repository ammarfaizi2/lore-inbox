Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbULBXxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbULBXxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 18:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbULBXxm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 18:53:42 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:37562 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261806AbULBXxH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 18:53:07 -0500
Date: Fri, 3 Dec 2004 00:18:37 +0100
From: Lukas Hejtmanek <xhejtman@hell.sks3.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Stefan Schmidt <zaphodb@zaphods.net>, marcelo.tosatti@cyclades.com,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: Kernel 2.6.9 Multiple Page Allocation Failures
Message-ID: <20041202231837.GB15185@mail.muni.cz>
References: <20041113144743.GL20754@zaphods.net> <20041116093311.GD11482@logos.cnet> <20041116170527.GA3525@mail.muni.cz> <20041121014350.GJ4999@zaphods.net> <20041121024226.GK4999@zaphods.net> <20041202195422.GA20771@mail.muni.cz> <20041202122546.59ff814f.akpm@osdl.org> <20041202210348.GD20771@mail.muni.cz> <20041202223146.GA31508@zaphods.net> <20041202145610.49e27b49.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041202145610.49e27b49.akpm@osdl.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 02:56:10PM -0800, Andrew Morton wrote:
> It's quite possible that XFS is performing rather too many GFP_ATOMIC
> allocations and is depleting the page reserves.  Although increasing
> /proc/sys/vm/min_free_kbytes should help there.

Btw, how the min_free_kbytes works?

I have up to 1MB TCP windows. If I'm running out of memory then kswapd should
try to free some memory (or bdflush). But on GE I can receive data faster then
disk is able to swap or flush buffers. So I should keep min_free big enough to
give time to disk to flush/swap data?


-- 
Luká¹ Hejtmánek
