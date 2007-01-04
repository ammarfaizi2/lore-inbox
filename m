Return-Path: <linux-kernel-owner+w=401wt.eu-S1030213AbXADU5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbXADU5v (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 15:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030219AbXADU5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 15:57:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44340 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1030213AbXADU5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 15:57:50 -0500
Date: Thu, 4 Jan 2007 12:57:39 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
cc: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix BUG_ON(!PageSlab) from fallback_alloc
In-Reply-To: <Pine.LNX.4.64.0701042249270.10892@sbz-30.cs.Helsinki.FI>
Message-ID: <Pine.LNX.4.64.0701041256560.23158@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0701041741490.16466@blonde.wat.veritas.com>
 <84144f020701041023g5910f40ej19a80905c9ed370@mail.gmail.com>
 <Pine.LNX.4.64.0701041042020.21800@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0701042249270.10892@sbz-30.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2007, Pekka J Enberg wrote:

> Something like this (totally untested) patch?

Yup. Moving the GFP_WAIT processing into kmem_getpages() will clean up a 
lot.
