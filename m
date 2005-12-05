Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932461AbVLERWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbVLERWl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 12:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932460AbVLERWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 12:22:41 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:10213 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932461AbVLERWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 12:22:40 -0500
Date: Mon, 5 Dec 2005 09:22:23 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/16] radixtree: sync with mainline
In-Reply-To: <20051205040535.GA5597@mail.ustc.edu.cn>
Message-ID: <Pine.LNX.4.62.0512050920370.11455@schroedinger.engr.sgi.com>
References: <20051203071444.260068000@localhost.localdomain>
 <20051203071625.331743000@localhost.localdomain> <20051204155750.3972c3df.akpm@osdl.org>
 <20051205040535.GA5597@mail.ustc.edu.cn>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2005, Wu Fengguang wrote:

> It is reproduced here on linux-2.6.15-rc3-mm1 with this single patch.
> I'm using qemu, and its screen outputs are not accessible. So I added some
> delays to the dump code, and grabbed two screen shots.

Lets drop this patch. __lookup_slot returns a pointer to the slot element 
and this patch changes the behavior of __lookup_slot making it return the 
contents of the slot. Without the indirection the address of the slot is 
not available so we need to keep the indirections in __lookup_slot.



