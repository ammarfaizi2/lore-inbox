Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUDGMew (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 08:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263018AbUDGMew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 08:34:52 -0400
Received: from ns.suse.de ([195.135.220.2]:55270 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262850AbUDGMev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 08:34:51 -0400
Date: Wed, 7 Apr 2004 14:34:47 +0200
From: Andi Kleen <ak@suse.de>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org,
       anton@samba.org, paulus@samba.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: RFC: COW for hugepages
Message-Id: <20040407143447.4d8f08af.ak@suse.de>
In-Reply-To: <20040407074239.GG18264@zax>
References: <20040407074239.GG18264@zax>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Apr 2004 17:42:39 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> Currently the kernel does not implement copy-on-write for huge pages -
> in fact any sort of page fault on a hugepage results in a SIGBUS.
> This means that hugepages *always* have MAP_SHARED semantics, even if
> MAP_PRIVATE is requested, and in particular that they are always
> shared across a fork().  Particularly when using hugetlbfs as just a
> source of quasi-anonymous memory, those are rather strange semantics.

[...]

Implementing this for ppc64 only is just wrong. Before you do this 
I would suggest to factor out the common code in the various hugetlbpage
implementations and then implement it in common code.

-Andi
