Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263025AbTEMVsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 17:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263183AbTEMVsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 17:48:06 -0400
Received: from holomorphy.com ([66.224.33.161]:16317 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263025AbTEMVsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 17:48:05 -0400
Date: Tue, 13 May 2003 15:00:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@digeo.com,
       mjbligh@us.ibm.com
Subject: Re: [RFC][PATCH] Interface to invalidate regions of mmaps
Message-ID: <20030513220041.GW8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@digeo.com,
	mjbligh@us.ibm.com
References: <20030513133636.C2929@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513133636.C2929@us.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 01:36:36PM -0700, Paul E. McKenney wrote:
> This patch adds an API to allow networked and distributed filesystems
> to invalidate portions of (or all of) a file.  This is needed to 
> provide POSIX or near-POSIX semantics in such filesystems, as
> discussed on LKML late last year:
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=103609089604576&w=2
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=103167761917669&w=2

It looks possible to consolidate this with the internals of vmtruncate()
by passing in the maximum value representable by loff_t as the length.


-- wli
