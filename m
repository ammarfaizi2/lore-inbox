Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312081AbSCTTr4>; Wed, 20 Mar 2002 14:47:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312082AbSCTTrq>; Wed, 20 Mar 2002 14:47:46 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:22788 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S312083AbSCTTrb>;
	Wed, 20 Mar 2002 14:47:31 -0500
Date: Wed, 20 Mar 2002 16:36:48 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Hugh Dickins <hugh@veritas.com>,
        Dave McCracken <dmccr@us.ibm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Creating a per-task kernel space for kmap, user pagetables, et
 al
In-Reply-To: <127930000.1016651345@flay>
Message-ID: <Pine.LNX.4.44L.0203201635570.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Mar 2002, Martin J. Bligh wrote:

> This, unfortunately, isn't a total solution - we may sometimes need to
> modify the task's pagetables from outside the process context, eg.
> swapout (thanks to dmc for pointing this out to me ;-)). For this, we'd
> just use the existing kmap mechanism to create another mapping to use
> temporarily, and we're no worse off than before. But on the whole I
> think it wins us enough to be worthwhile.

There is absolutely no problem mapping the page tables of
another process into our own kmap space. It's just like
what the kernel does now, except that it'll be scalable
because each process has its own kmap array.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

