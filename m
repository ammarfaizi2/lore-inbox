Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317599AbSFIMBX>; Sun, 9 Jun 2002 08:01:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSFIMBW>; Sun, 9 Jun 2002 08:01:22 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:48390 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317599AbSFIMBW>; Sun, 9 Jun 2002 08:01:22 -0400
Date: Sun, 9 Jun 2002 13:01:15 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Lightweight patch manager <patch@luckynet.dynu.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] introduce list_move macros
Message-ID: <20020609130115.A22462@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.44.0206090508330.22407-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 05:09:54AM -0600, Lightweight patch manager wrote:
> +/**
> + * list_move           - move a list entry from a right after b
> + * @list       the entry to move
> + * @head       the entry to move after
> + */
> +#define list_move(list,head) \
> +        list_del(list); \
> +        list_add(list,head)

Yuck.  What if someone does:

	if (foo)
		list_move(list,head);

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

