Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUEEPdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUEEPdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 11:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbUEEPdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 11:33:37 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:12809 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264697AbUEEPdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 11:33:24 -0400
Date: Wed, 5 May 2004 16:33:20 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, arnd@arndb.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-ID: <20040505163320.A4250@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, arnd@arndb.de,
	linux-kernel@vger.kernel.org
References: <20040505013135.7689e38d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040505013135.7689e38d.akpm@osdl.org>; from akpm@osdl.org on Wed, May 05, 2004 at 01:31:35AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 01:31:35AM -0700, Andrew Morton wrote:
>static-define_per_cpu-vs-modules-2.patch
> 
>  Work around relative address displacement problems on s390.

I'm not happy with this one.  It prevents perfectly valid optimizations
that become more important with modern compilers because of s390 brokenness.

Of the options listed in the patch description (why the heck didn't it ever
make it to a mailinglist??) the options to avoid the static effect in s390
code looks most appealing but hard to implement to me, and if it doesn't
work out we'll probably have to do the STATIC_DEFINE_PER_CPU variant.

