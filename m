Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261185AbUK0Kmf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261185AbUK0Kmf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 05:42:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUK0Kmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 05:42:35 -0500
Received: from [213.85.13.118] ([213.85.13.118]:15232 "EHLO tau.rusteko.ru")
	by vger.kernel.org with ESMTP id S261185AbUK0Kmd (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 05:42:33 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16808.23030.312384.635657@gargle.gargle.HOWL>
Date: Sat, 27 Nov 2004 13:41:58 +0300
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Andrew Morton <AKPM@Osdl.ORG>,
       Linux MM Mailing List <linux-mm@kvack.org>
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
In-Reply-To: <20041126185833.GA7740@logos.cnet>
References: <16800.47044.75874.56255@gargle.gargle.HOWL>
	<20041126185833.GA7740@logos.cnet>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:

[...]

 > 
 > Average Half Load -j 4 Run:                     Average Half Load -j 4 Run:
 > Elapsed Time 274.916                            Elapsed Time 245.026
 > User Time 833.63                                User Time 832.34
 > System Time 73.704                              System Time 73.41
 > Percent CPU 335.8                               Percent CPU 373.6
 > Context Switches 12984.8                        Context Switches 13427.4
 > Sleeps 21459.2                                  Sleeps 21642

What is "System Time" here? Does in include CPU consumption by, say,
kswapd? If not, then one may conjecture that mark_page_accessed batching
modifies ordering of pages on zone "LRU" lists in a way that measurably
changes efficiency of VM scanning, and mostly affects process that scans
most---kswapd.

Nikita.

