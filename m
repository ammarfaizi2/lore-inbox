Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131237AbQLUXaV>; Thu, 21 Dec 2000 18:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131199AbQLUXaB>; Thu, 21 Dec 2000 18:30:01 -0500
Received: from [199.239.160.155] ([199.239.160.155]:46341 "EHLO
	tenchi.datarithm.net") by vger.kernel.org with ESMTP
	id <S129697AbQLUX3w>; Thu, 21 Dec 2000 18:29:52 -0500
Date: Thu, 21 Dec 2000 15:08:45 -0800
From: Robert Read <rread@datarithm.net>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Sourav Sen <sourav@csa.iisc.ernet.in>, linux-kernel@vger.kernel.org
Subject: Re: Wiring down Pages
Message-ID: <20001221150845.I24558@tenchi.datarithm.net>
Mail-Followup-To: Rik van Riel <riel@conectiva.com.br>,
	Sourav Sen <sourav@csa.iisc.ernet.in>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SOL.3.96.1001222011552.20552A-100000@kohinoor.csa.iisc.ernet.in> <Pine.LNX.4.21.0012211845070.1613-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0012211845070.1613-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Thu, Dec 21, 2000 at 06:46:33PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 21, 2000 at 06:46:33PM -0200, Rik van Riel wrote:
> 
> page_cache_drop(page); <= removes your extra count

I can't find that function, do you mean page_cache_free() and
page_cache_release(), both are aliases for __free_page(). Maybe we
need another alias. :)

Should non-page cache related code use get_page() and __free_page()
directly?  Or should the page_cache_* macros be used everywhere?

robert
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
