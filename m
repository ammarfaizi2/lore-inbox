Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWBOEh5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWBOEh5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 23:37:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWBOEh5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 23:37:57 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:64893 "HELO
	smtp105.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750916AbWBOEh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 23:37:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=E/CAVEq1XOOmCydQSD0TlOi7FtXCth+WSLFCOTFQ1N5mg50kE586RvyFiKRGUkECW9Lp93sRFrn+6wVtREy6yqpvi9plHuaoc6qQZQgSduWCU07Bl8esGOLddZNuCOh0hA22sst1e3+s5Qk+tPC7L3QEmZPQAVGTKyuS0+Jb+9k=  ;
Message-ID: <43F2AEAE.5010700@yahoo.com.au>
Date: Wed, 15 Feb 2006 15:31:42 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
CC: Andrew Morton <akpm@osdl.org>, Hugh Dickins <hugh@veritas.com>,
       William Irwin <wli@holomorphy.com>, Roland Dreier <rdreier@cisco.com>,
       Gleb Natapov <gleb@minantech.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       openib-general@openib.org, Petr Vandrovec <vandrove@vc.cvut.cz>,
       Badari Pulavarty <pbadari@us.ibm.com>,
       Grant Grundler <grundler@parisc-linux.org>,
       Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] madvise MADV_DONTFORK/MADV_DOFORK
References: <20060213154114.GO32041@mellanox.co.il> <Pine.LNX.4.64.0602131104460.3691@g5.osdl.org> <adar767133j.fsf@cisco.com> <Pine.LNX.4.64.0602131125180.3691@g5.osdl.org> <Pine.LNX.4.61.0602131943050.9573@goblin.wat.veritas.com> <20060213210906.GC13603@mellanox.co.il> <Pine.LNX.4.61.0602132157110.3761@goblin.wat.veritas.com> <Pine.LNX.4.64.0602131426470.3691@g5.osdl.org> <20060213225538.GE13603@mellanox.co.il> <Pine.LNX.4.61.0602132259450.4627@goblin.wat.veritas.com> <20060213233517.GG13603@mellanox.co.il>
In-Reply-To: <20060213233517.GG13603@mellanox.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael S. Tsirkin wrote:

> Index: linux-2.6.16-rc2/include/asm-x86_64/mman.h
> ===================================================================
> --- linux-2.6.16-rc2.orig/include/asm-x86_64/mman.h	2006-02-14 01:22:27.000000000 +0200
> +++ linux-2.6.16-rc2/include/asm-x86_64/mman.h	2006-02-14 01:24:57.000000000 +0200
> @@ -37,6 +37,8 @@
>  #define MADV_WILLNEED	0x3		/* pre-fault pages */
>  #define MADV_DONTNEED	0x4		/* discard these pages */
>  #define MADV_REMOVE	0x5		/* remove these pages & resources */
> +#define MADV_DONTFORK	0x30		/* dont inherit across fork */
> +#define MADV_DOFORK	0x31		/* do inherit across fork */
>  

May I ask, what is the rationale for ignoring the apparent conventions
of all architectures? For example parisc, you appear to even go contrary
to the comment.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
