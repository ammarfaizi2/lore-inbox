Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319140AbSHGS7Q>; Wed, 7 Aug 2002 14:59:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319141AbSHGS7P>; Wed, 7 Aug 2002 14:59:15 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:47375 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319140AbSHGS7O>; Wed, 7 Aug 2002 14:59:14 -0400
Date: Wed, 7 Aug 2002 20:02:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Alexandre Julliard <julliard@winehq.com>
Subject: Re: [patch] tls-2.5.30-A1
Message-ID: <20020807200251.A13605@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Julliard <julliard@winehq.com>
References: <Pine.LNX.4.44.0208072001490.22133-200000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208072001490.22133-200000@localhost.localdomain>; from mingo@elte.hu on Wed, Aug 07, 2002 at 08:10:40PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 08:10:40PM +0200, Ingo Molnar wrote:
> 
> the attached patch (against BK-curr + Luca Barbieri's two TLS patches)  
> does two things:
> 
>  - it implements a second TLS entry for Wine's purposes.

The sys_set_thread_area interface gets worse with every patch you post..

Why do you really need a magic multiplexer syscall (you could have just
used prctl if you don't need a sane interface..)?

What about a proper interface like:

asmlinkage int
sys_set_thread_area(int entry, unsigned long base, int writeable)

instead?

