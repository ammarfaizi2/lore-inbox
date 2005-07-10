Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVGJGPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVGJGPp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Jul 2005 02:15:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261861AbVGJGPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Jul 2005 02:15:45 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:20493 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261860AbVGJGPl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Jul 2005 02:15:41 -0400
Date: Sun, 10 Jul 2005 08:11:48 +0200
From: Willy Tarreau <willy@w.ods.org>
To: guorke <gourke@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: I confused about diff(simple question)
Message-ID: <20050710061147.GO8907@alpha.home.local>
References: <d73ab4d005070922413fb0dbba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d73ab4d005070922413fb0dbba@mail.gmail.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 10, 2005 at 01:41:40PM +0800, guorke wrote:
> like:
> 
>  /*
> @@ -220,9 +232,8(HERE: why not -220,9 +220,8) @@ fastcall notrace void
> do_page_fault(stru
>        struct vm_area_struct * vma;
>        unsigned long address;
>        unsigned long page;
> -       int write;
> -       siginfo_t info;
> -
> +       int write, si_code;
> +

(...) 
>  I think the old file from the line 220,and have 9 lines,then the
> newfile have 8 lines
> so must delete one line. but why +232,it from the line 232 ?
> like this..

because there was another chunk before this one, which added 12 lines,
so the offset in the old file is 220, and the offset in the new file is
232 because of the previous chunk.

Willy

