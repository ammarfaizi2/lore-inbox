Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316795AbSFJJgq>; Mon, 10 Jun 2002 05:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316796AbSFJJgp>; Mon, 10 Jun 2002 05:36:45 -0400
Received: from pc2-redb4-0-cust125.bre.cable.ntl.com ([213.107.133.125]:28661
	"HELO opel.itsolve.co.uk") by vger.kernel.org with SMTP
	id <S316795AbSFJJgp>; Mon, 10 Jun 2002 05:36:45 -0400
Date: Sun, 9 Jun 2002 12:23:16 +0100
From: Mark Zealey <mark@zealos.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] introduce list_move macros
Message-ID: <20020609112316.GB744@itsolve.co.uk>
In-Reply-To: <Pine.LNX.4.44.0206090508330.22407-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux sunbeam 2.4.19-pre8-ac1 
X-Homepage: http://zealos.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 05:09:54AM -0600, Lightweight patch manager wrote:

> +#define list_move(list,head) \
> +        list_del(list); \
> +        list_add(list,head)
> +
> +/**
> + * list_move_tail      - move a list entry from a right before b

> +#define list_move(list,head) \

I guess that should be:
+#define list_move_tail(list,head) \

You should enclose the ops in a do { ... } while(0) block too.

-- 

Mark Zealey (aka JALH on irc.openprojects.net: #zealos and many more)
mark@zealos.org; mark@itsolve.co.uk

UL++++>$ G!>(GCM/GCS/GS/GM) dpu? s:-@ a17! C++++>$ P++++>+++++$ L+++>+++++$
!E---? W+++>$ !w--- r++ !t---?@ !X---?  !R- !tv b+ G+++ e>+++++ !h++* r!-- y--
