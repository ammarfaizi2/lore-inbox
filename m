Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbRGGCMe>; Fri, 6 Jul 2001 22:12:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265705AbRGGCMY>; Fri, 6 Jul 2001 22:12:24 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:24518 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265670AbRGGCMI>;
	Fri, 6 Jul 2001 22:12:08 -0400
Message-ID: <3B466FF7.81138181@mandrakesoft.com>
Date: Fri, 06 Jul 2001 22:12:07 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH #2] OOM kill trigger
In-Reply-To: <Pine.LNX.4.33L.0107061930390.17825-100000@duckman.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> +       cache_mem = atomic_read(&page_cache_size);
> +       cache_mem += atomic_read(&buffermem_pages);
> +       cache_mem -= swapper_space.nrpages;
> +       limit = (page_cache.min_percent + buffer_mem.min_percent);

Don't you need extra protection around swapper_space.nrpages?  A barrier
right above it?

-- 
Jeff Garzik      | A recent study has shown that too much soup
Building 1024    | can cause malaise in laboratory mice.
MandrakeSoft     |
