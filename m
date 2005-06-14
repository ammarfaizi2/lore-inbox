Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261254AbVFNQ42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVFNQ42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 12:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261255AbVFNQ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 12:56:28 -0400
Received: from one.firstfloor.org ([213.235.205.2]:10471 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261254AbVFNQ4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 12:56:25 -0400
To: Steve Lord <lord@xfs.org>
Cc: "K.R. Foley" <kr@cybsft.com>, pozsy@uhulinux.hu,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org> <20050610112515.691dcb6e.akpm@osdl.org>
	<20050611082642.GB17639@ojjektum.uhulinux.hu>
	<42AAE5C8.9060609@xfs.org>
	<20050611150525.GI17639@ojjektum.uhulinux.hu>
	<42AB25E7.5000405@xfs.org> <20050611120040.084942ed.akpm@osdl.org>
	<42AEDCFB.8080002@xfs.org> <42AEF979.2000207@cybsft.com>
	<42AF080A.1000307@xfs.org>
From: Andi Kleen <ak@muc.de>
Date: Tue, 14 Jun 2005 18:56:22 +0200
In-Reply-To: <42AF080A.1000307@xfs.org> (Steve Lord's message of "Tue, 14
 Jun 2005 11:38:34 -0500")
Message-ID: <m14qc0c1xl.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord <lord@xfs.org> writes:
>
> So is this some P4 specific optimization which is not working as
> intended?

The only pentium specific optimizations that are enabled by MPENTIUM4
is to tell the compiler to compile for pentium4 and a few settings
in arch/i386/Kconfig.

You could enable/disable these individually and see if you can track
it down with a binary search.

Most of this stuff should be fairly harmless though and be only
microoptimizations; I cannot see how they should cause user visible
races.

-Andi
