Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289985AbSAWTXf>; Wed, 23 Jan 2002 14:23:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289988AbSAWTXa>; Wed, 23 Jan 2002 14:23:30 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:53517 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289985AbSAWTWv>;
	Wed, 23 Jan 2002 14:22:51 -0500
Date: Wed, 23 Jan 2002 17:22:30 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] rmap VM, version 12
In-Reply-To: <20020123.110624.93021436.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L.0201231720460.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jan 2002, David S. Miller wrote:

>    Actually, this is just using the pte_free_fast() and
>    {get,free}_pgd_fast() functions on non-pae machines.
>
> Rofl, you can't just do that.  The page tables cache caches the kernel
> mappings and if you don't update them properly on SMP you die.

Umm, this list just contains _freed_ page tables without
any mappings, right ?

If there is some specific magic I'm missing, could you
please point me to the code I'm overlooking ? ;)

> I am seeing reports of SMP failing with rmap12 but not previous
> patches.  You need to revert this I think.

Actually, the cause for Badari's bugreport is much more
stupid.  If it wasn't so stupid I bet I'd have found it
earlier...

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/


