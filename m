Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262370AbUDHTs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262381AbUDHTs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:48:27 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:55956 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262370AbUDHTs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:48:26 -0400
Date: Thu, 8 Apr 2004 20:48:22 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Rajesh Venkatasubramanian <vrajesh@umich.edu>
cc: mbligh@aracnet.com, <akpm@osdl.org>, <andrea@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: NUMA API for Linux
In-Reply-To: <Pine.LNX.4.58.0404081503110.28416@ruby.engin.umich.edu>
Message-ID: <Pine.LNX.4.44.0404082029390.7600-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Apr 2004, Rajesh Venkatasubramanian wrote:
> 
> I guess using vm_private_data for nonlinear is not a problem because
> we use list i_mmap_nonlinear for nonlinear vmas.
> 
> As you have found out vm_private_data is only used if vm_file != NULL
> or VM_RESERVED or VM_DONTEXPAND is set. I think we can revert back to
> i_mmap{_shared} list for such special cases and use prio_tree for
> others. I maybe missing something. Please teach me.

Sorry, I don't understand what you're proposing here, and why?
Oh, to save 4 bytes of vma by making the special cases use a list,
no need for vm_set_head, and vm_private_data for the driver itself;
but regular vmas use prio_tree, with vm_set_head in vm_private_data.
Hmm, right now it's getting too much for me: can we keep it simplish
for now, and come back to this later?

Hugh

