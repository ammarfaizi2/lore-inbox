Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbTBUOsO>; Fri, 21 Feb 2003 09:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbTBUOsO>; Fri, 21 Feb 2003 09:48:14 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:33726 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S267482AbTBUOsN>;
	Fri, 21 Feb 2003 09:48:13 -0500
Date: Fri, 21 Feb 2003 15:10:32 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] replace flush_map() in arch/i386/mm/pageattr.c w ith flush_tlb_all()
Message-ID: <20030221151032.GD22285@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Hugh Dickins <hugh@veritas.com>,
	Thomas Schlichter <schlicht@uni-mannheim.de>,
	Andrew Morton <akpm@digeo.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20030221142039.GA21532@codemonkey.org.uk> <Pine.LNX.4.44.0302211439590.1669-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302211439590.1669-100000@localhost.localdomain>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 02:52:38PM +0000, Hugh Dickins wrote:

 > Of course that's much much better.  But I think rather better as
 > static inline void on_each_cpu(void (*func) (void *info), void *info)
 > passing info to func instead of assuming NULL.  inline? maybe.

Sounds good to me. As for inline - This thing will be generating lots
of IPIs on SMP, so its hardly going to be performance critical, so
we could leave it out of line IMO.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
