Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUDHQPe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:15:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUDHQPc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:15:32 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:11164 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261991AbUDHQP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:15:27 -0400
Date: Thu, 8 Apr 2004 17:15:24 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, <mbligh@aracnet.com>, <colpatch@us.ibm.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: NUMA API for Linux
In-Reply-To: <20040407165639.2198b215.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0404081641450.7277-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004, Andrew Morton wrote:
> 
> Your patch takes the CONFIG_NUMA vma from 64 bytes to 68.  It would be nice
> to pull those 4 bytes back somehow.

How significant is this vma size issue?

anon_vma objrmap will add 20 bytes to each vma (on 32-bit arches):
8 for prio_tree, 12 for anon_vma linkage in vma,
sometimes another 12 for the anon_vma head itself.

anonmm objrmap adds just the 8 bytes for prio_tree,
remaining overhead 28 bytes per mm.

Seems hard on Andi to begrudge him 4.

Hugh

