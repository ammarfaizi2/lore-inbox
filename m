Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265690AbUGDTWx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265690AbUGDTWx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 15:22:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265719AbUGDTWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 15:22:52 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:42730 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S265690AbUGDTWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 15:22:45 -0400
Date: Sun, 4 Jul 2004 20:22:35 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: William Lee Irwin III <wli@holomorphy.com>
cc: linux-kernel@vger.kernel.org, <akpm@osdl.org>
Subject: Re: spurious remap_file_pages() -EINVAL
In-Reply-To: <20040704120401.GE21066@holomorphy.com>
Message-ID: <Pine.LNX.4.44.0407042021400.5234-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jul 2004, William Lee Irwin III wrote:
> As ->vm_private_data is used as a cursor for swapout of VM_NONLINEAR
> vmas, the check for NULL ->vm_private_data or VM_RESERVED is too
> strict, and should allow VM_NONLINEAR vmas with non-NULL ->vm_private_data.
> 
> This fixes an issue on 2.6.7-mm5 where system calls to remap_file_pages()
> spuriously failed while under memory pressure.

How embarrassing!  Yes, thank you.

Hugh

