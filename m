Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTEACh4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 22:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262111AbTEACh4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 22:37:56 -0400
Received: from holomorphy.com ([66.224.33.161]:30679 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262109AbTEAChz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 22:37:55 -0400
Date: Wed, 30 Apr 2003 19:49:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Keith Mannthey <kmannth@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] clustered apic irq affinity fix for i386
Message-ID: <20030501024948.GF8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, Keith Mannthey <kmannth@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <1051744032.16886.80.camel@dyn9-47-17-180.beaverton.ibm.com> <20030430163637.04f06ba6.akpm@digeo.com> <1051751157.16886.91.camel@dyn9-47-17-180.beaverton.ibm.com> <20030430192205.13491d61.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030430192205.13491d61.akpm@digeo.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 30, 2003 at 07:22:05PM -0700, Andrew Morton wrote:
> Is it not possible to fix set_ioapic_affinity() for real for clustered APIC
> mode?  What is involved in that?

The clustered hierarchical destination format formats destinations as

bits | 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 |
--------------------------------------
     | cluster id no | local cpumask |
--------------------------------------

which can only describe 15*16 of the 2**60 nonempty subsets of 60 cpus.


-- wli
