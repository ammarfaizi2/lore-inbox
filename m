Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263874AbSIQHxv>; Tue, 17 Sep 2002 03:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263878AbSIQHxu>; Tue, 17 Sep 2002 03:53:50 -0400
Received: from smtpde02.sap-ag.de ([155.56.68.170]:40869 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S263874AbSIQHxu>; Tue, 17 Sep 2002 03:53:50 -0400
From: Christoph Rohland <cr@sap.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@digeo.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: dbench on tmpfs OOM's
References: <Pine.LNX.4.44.0209170726050.19523-100000@localhost.localdomain>
Organisation: Development SAP J2EE Engine
Date: Tue, 17 Sep 2002 09:57:18 +0200
In-Reply-To: <Pine.LNX.4.44.0209170726050.19523-100000@localhost.localdomain> (Hugh
 Dickins's message of "Tue, 17 Sep 2002 08:01:20 +0100 (BST)")
Message-ID: <sn092gm9.fsf@sap.com>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) XEmacs/21.4 (Common Lisp
 (Windows [3]), i586-pc-win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Tue, 17 Sep 2002, Hugh Dickins wrote:
> What I never did was try GFP_HIGHUSER and kmap on the index pages:
> I think I decided back then that it wasn't likely to be needed
> (sparsely filled file indexes are a rarer case than sparsely filled
> pagetables, once the stupidity is fixed; and small files don't use
> index pages at all).  But Bill's testing may well prove me wrong.

I think that this would be a good improvement. Big database and
application servers would definitely benefit from it, desktops could
easier use tmpfs as temporary file systems.

I never dared to do it with my limited time since I feared deadlock
situations.

Also I ended up that I would try to go one step further: Make the
index pages swappable, i.e. make the directory nodes normal tmpfs
files. This would even make the accounting right.

Greetings
		Christoph


