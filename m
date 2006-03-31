Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbWCaN20@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbWCaN20 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 08:28:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932131AbWCaN20
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 08:28:26 -0500
Received: from mx1.suse.de ([195.135.220.2]:60867 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932120AbWCaN2Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 08:28:25 -0500
To: Christoph Lameter <clameter@sgi.com>
Cc: Zoltan Menyhart <Zoltan.Menyhart@bull.net>,
       "Boehm, Hans" <hans.boehm@hp.com>,
       "Grundler, Grant G" <grant.grundler@hp.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Synchronizing Bit operations V2
References: <Pine.LNX.4.64.0603301300430.1014@schroedinger.engr.sgi.com>
	<Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
From: Andi Kleen <ak@suse.de>
Date: 31 Mar 2006 15:28:17 +0200
In-Reply-To: <Pine.LNX.4.64.0603301615540.2023@schroedinger.engr.sgi.com>
Message-ID: <p73vetu921a.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter <clameter@sgi.com> writes:
> MODE_BARRIER
> 	An atomic operation that is guaranteed to occur between
> 	previous and later memory operations.


I think it's a bad idea to create such an complicated interface.
The chances that an average kernel coder will get these right are
quite small. And it will be 100% untested outside IA64 I guess
and thus likely be always slightly buggy as kernel code continues
to change.

-Andi
