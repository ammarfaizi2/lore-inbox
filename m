Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261628AbRFGPoC>; Thu, 7 Jun 2001 11:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261651AbRFGPnw>; Thu, 7 Jun 2001 11:43:52 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:23805 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S261628AbRFGPni>; Thu, 7 Jun 2001 11:43:38 -0400
Date: Thu, 7 Jun 2001 16:44:06 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: John Stoffel <stoffel@casc.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH] Reap dead swap cache earlier v2
In-Reply-To: <15135.37871.373389.465893@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.21.0106071640410.1596-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jun 2001, John Stoffel wrote:
> Shouldn't the "swap_count(page) == 1" check be earlier in the if
> statement, so we can fall through more quickly if there is no work to
> be done?  A small optimization, but putting the common cases first
> will help.

I don't think so: the out-of-line swap_count() function is considerably
more complicated than the macros and inline functions tested before it.

Hugh

