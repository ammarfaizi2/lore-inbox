Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287177AbSAPTe4>; Wed, 16 Jan 2002 14:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287231AbSAPTeq>; Wed, 16 Jan 2002 14:34:46 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:20489 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S287155AbSAPTel>;
	Wed, 16 Jan 2002 14:34:41 -0500
Date: Wed, 16 Jan 2002 17:34:26 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, <linux-kernel@vger.kernel.org>
Subject: Re: pte-highmem-5
In-Reply-To: <Pine.LNX.4.33.0201161008270.2112-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33L.0201161732310.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2002, Linus Torvalds wrote:

>  - do the highmem pte bouncing only for CONFIG_X86_PAE: with less then 4GB
>    of RAM this doesn't seem to matter all that much (rule of thumb: we
>    need about 1% of memory for page tables).

Actually, with 100 processes mapping a 1 GB area of shared
memory, you'll need about 100 MB of page tables or 10% of
the SHM segment. This rises even further with PAE and/or
more processes.

The page table cost for heavily shared memory segments is
really getting out of hand, IMHO ... it might be worth it
to set aside a separate memory zone and use 4 MB pages for
the SHM segment.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

