Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSDZLyE>; Fri, 26 Apr 2002 07:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313898AbSDZLyD>; Fri, 26 Apr 2002 07:54:03 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:45063 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S313867AbSDZLyD>; Fri, 26 Apr 2002 07:54:03 -0400
Date: Fri, 26 Apr 2002 12:53:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org,
        Ihno Krumreich <ihno@suse.de>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: get_pid fixes against 2.4.19pre7
Message-ID: <20020426125347.A18131@flint.arm.linux.org.uk>
In-Reply-To: <20020426134409.C19278@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 01:44:09PM +0200, Andrea Arcangeli wrote:
> +			set_bit(p->pid, pid_bitmap);
> +			set_bit(p->pgrp, pid_bitmap);
> +			set_bit(p->tgid, pid_bitmap);
> +			set_bit(p->session, pid_bitmap);

Since we're running under a lock, do we really need the guaranteed
atomic (and therefore expensive) set_bit(), or would __set_bit()
suffice?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

