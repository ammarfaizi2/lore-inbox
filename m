Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbUDLTKs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 15:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263031AbUDLTKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 15:10:48 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:15860 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263028AbUDLTKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 15:10:46 -0400
Date: Mon, 12 Apr 2004 20:10:38 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Martin J. Bligh" <mbligh@aracnet.com>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Rajesh Venkatasubramanian <vrajesh@umich.edu>
Subject: Re: [PATCH] anobjrmap 9 priority mjb tree
In-Reply-To: <3360000.1081796512@[10.10.2.4]>
Message-ID: <Pine.LNX.4.44.0404122006050.10504-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Apr 2004, Martin J. Bligh wrote:
> 
> If it were just a list, maybe RCU would be appropriate. It might be
> rather write-heavy though ? I think I played with an rwsem instead
> of a sem in the past too (though be careful if you try this, as for
> no good reason the return codes are inverted ;-()

Yes, I think all the common paths have to write, in case the
uncommon paths (truncation and swapout) want to read: the wrong
way round for any kind of read-write optimization, isn't it?

Hugh

