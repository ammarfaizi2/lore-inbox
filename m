Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263374AbTH0NJU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 09:09:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263377AbTH0NJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 09:09:20 -0400
Received: from meg.hrz.tu-chemnitz.de ([134.109.132.57]:46034 "EHLO
	meg.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S263374AbTH0NJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 09:09:19 -0400
Date: Wed, 27 Aug 2003 09:52:41 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jaroslav Kysela <perex@suse.cz>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
Subject: Re: Strange memory usage reporting
Message-ID: <20030827095241.D639@nightmaster.csn.tu-chemnitz.de>
References: <Pine.LNX.4.44.0308261550240.1958-100000@pnote.perex-int.cz> <Pine.LNX.4.44.0308261756570.1632-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.44.0308261756570.1632-100000@localhost.localdomain>; from hugh@veritas.com on Tue, Aug 26, 2003 at 06:03:14PM +0100
X-Spam-Score: -4.7 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19s033-0004IK-00*c6coH0gMtDk*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 26, 2003 at 06:03:14PM +0100, Hugh Dickins wrote:
> Which is the driver involved?  Though it's not wrong to give do_no_page
> a Reserved page, beware of the the page->count accounting: while it's
> Reserved, get_page or page_cache_get raises the count, but put_page
> or page_cache_release does not decrement it - very easy to end up
> with the page never freed.

Why is this so asymetric? I would understand ignoring these pages
in the freeing logic, but why exclude them also from refcounting?

Regards

Ingo Oeser
