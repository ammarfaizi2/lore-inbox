Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290553AbSA3U1H>; Wed, 30 Jan 2002 15:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290557AbSA3U1B>; Wed, 30 Jan 2002 15:27:01 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:811 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S290553AbSA3U0t>; Wed, 30 Jan 2002 15:26:49 -0500
Date: Wed, 30 Jan 2002 21:27:57 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 18pre7aa1 pagetable corroops
Message-ID: <20020130212757.K1309@athlon.random>
In-Reply-To: <20020130111810.A1309@athlon.random> <Pine.LNX.4.21.0201301753420.1035-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.21.0201301753420.1035-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Jan 30, 2002 at 05:55:38PM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 05:55:38PM +0000, Hugh Dickins wrote:
> clear_pagetable corrupts memory and oopses when CONFIG_HIGHMEM,
> but the pagetable has been allocated from low memory.

right, thanks. BTW, I kept the other fixmap_init code beause of the many
more BUG() checks (like the PTRS_PER_PMD checks with PAE) and because
it is equivalent after all.

Andrea
