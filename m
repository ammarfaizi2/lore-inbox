Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262358AbVAENSS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262358AbVAENSS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 08:18:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262365AbVAENSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 08:18:18 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:14862 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262358AbVAENSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 08:18:09 -0500
Date: Wed, 5 Jan 2005 13:17:48 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Christoph Hellwig <hch@infradead.org>
cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] merge *_vm_enough_memory()s into a common helper
In-Reply-To: <20050105112554.GB31119@infradead.org>
Message-ID: <Pine.LNX.4.44.0501051311060.2844-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2005, Christoph Hellwig wrote:
> On Tue, Jan 04, 2005 at 03:48:33PM -0600, Serge E. Hallyn wrote:
> > The attached patch introduces a __vm_enough_memory function in
> > security/security.c which is used by cap_vm_enough_memory,
> > dummy_vm_enough_memory, and selinux_vm_enough_memory.  This has
> > been discussed on the lsm mailing list.
> > 
> > Are there any objections to or comments on this patch?
> 
> Maybe this function should go into mm/ ?

My thought exactly: yes, please do move it back into mm/,
where it started out before security/ came into the picture.

But where in mm?  I suppose either mm/mmap.c where vm_committed_space
is still declared, or (that strange ragbag) mm/swap.c where the
CONFIG_SMP vm_acct_memory is.

Hugh

