Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262665AbUC2Fiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 00:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262673AbUC2Fiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 00:38:55 -0500
Received: from holomorphy.com ([207.189.100.168]:12697 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262665AbUC2Fiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 00:38:54 -0500
Date: Sun, 28 Mar 2004 21:38:47 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Keith Owens <kaos@sgi.com>
Cc: Paul Jackson <pj@sgi.com>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, akpm@osdl.org,
       haveblue@us.ibm.com
Subject: Re: [PATCH] nodemask_t x86_64 changes [5/7]
Message-ID: <20040329053847.GJ791@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Keith Owens <kaos@sgi.com>, Paul Jackson <pj@sgi.com>,
	colpatch@us.ibm.com, linux-kernel@vger.kernel.org,
	mbligh@aracnet.com, akpm@osdl.org, haveblue@us.ibm.com
References: <20040325231412.2a3d1c15.pj@sgi.com> <4865.1080536926@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4865.1080536926@kao2.melbourne.sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2004 at 03:08:46PM +1000, Keith Owens wrote:
> For big endian, ~0UL << NR_CPUS_UNDEF is right.  For little endian, it
> depends on how you represent an incomplete bit map.  Is it represented
> as a pure bit string, i.e. as if the arch were big endian?  Or is it
> represented as a mapping onto the bytes of the underlying long?

Bitmaps are represented in Linux in such manners as befit wrong
(little) endian machines. I suggest shifting in the opposite direction.


-- wli
