Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318999AbSHST4I>; Mon, 19 Aug 2002 15:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319002AbSHST4I>; Mon, 19 Aug 2002 15:56:08 -0400
Received: from dsl-213-023-038-214.arcor-ip.net ([213.23.38.214]:25476 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318999AbSHST4I>;
	Mon, 19 Aug 2002 15:56:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>, Andrew Morton <akpm@zip.com.au>
Subject: Re: [PATCH] rmap bugfix, try_to_unmap
Date: Mon, 19 Aug 2002 22:01:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
References: <Pine.LNX.4.44L.0208121156160.23404-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0208121156160.23404-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17gsiW-0000rS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 12 August 2002 16:58, Rik van Riel wrote:
>  	case SWAP_FAIL:
>  		ret = SWAP_FAIL;
> -		break;
> +		goto give_up;

Yes, I looked at that many times while reading the break as a 'break
from loop' every time.  Using the same keyword to mean 'stop looping'
and 'endcase' was, by any measure, a stupid idea.

-- 
Daniel
