Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261499AbSJMLlR>; Sun, 13 Oct 2002 07:41:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261501AbSJMLlR>; Sun, 13 Oct 2002 07:41:17 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50826 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261499AbSJMLlQ>; Sun, 13 Oct 2002 07:41:16 -0400
Date: Sun, 13 Oct 2002 12:47:56 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andi Kleen <ak@suse.de>
cc: "David S. Miller" <davem@redhat.com>, <wagnerjd@prodigy.net>,
       <robm@fastmail.fm>, <hahn@physics.mcmaster.ca>,
       <linux-kernel@vger.kernel.org>, <jhoward@fastmail.fm>
Subject: Re: Strange load spikes on 2.4.19 kernel
In-Reply-To: <p73elaupzrj.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0210131244110.1242-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Oct 2002, Andi Kleen wrote:
> 
> Still in 2.4 the VFS takes the big kernel lock unnecessarily for
> a few VFS operations (no matter if the underlying FS needs it or not).
> That's fixed in 2.5.

Something I was a bit surprised to notice recently: 2.5 still holds
big kernel lock around the potentially very lengthy vmtruncate() -
is that one still really necessary at VFS level?

Hugh

