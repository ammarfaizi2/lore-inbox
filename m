Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTEJJWr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 05:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTEJJWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 05:22:47 -0400
Received: from zeus.kernel.org ([204.152.189.113]:19607 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263695AbTEJJWq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 05:22:46 -0400
Date: Sat, 10 May 2003 05:24:13 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Joshua Kwan <joshk@triplehelix.org>
cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OOPS in smbfs module - 2.5.69-mm1
In-Reply-To: <20030510053548.GA23841@triplehelix.org>
Message-ID: <Pine.LNX.4.50.0305100440150.11047-100000@montezuma.mastecende.com>
References: <20030510053548.GA23841@triplehelix.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003, Joshua Kwan wrote:

> Got this trying to mount my MP3 partition in 2.5.69-mm1...
> 
> Unable to handle kernel paging request at virtual address af0272f7
>  printing eip:
> d4c8ffe9
> *pde = 00000000
> Oops: 0000 [#1]
> CPU:    0
> EIP:    0060:[<d4c8ffe9>]    Not tainted VLI
> EFLAGS: 00010246
> EIP is at find_request+0x15/0x45 [smbfs]

<snip>

> Code: 1b 8b 46 1c 89 58 04 89 03 89 7b 04 89 5e 1c b8 fb ff ff ff eb ac
> 57 31 c9 56 53 8b 7c 24 10 8b 74 24 14 8b 57 24 8b 02 0f 18 00 <63> 8d
> 5f 24 39 da 74 15 39 72 18 89 d1 74 0e 89 c2 31 c9 8b 00

You appear to be in a very bad place, looks like list corruption, possibly 
a prefetch into never never land, which gcc version are you using? Can you 
reproduce easily?

-- 
function.linuxpower.ca
