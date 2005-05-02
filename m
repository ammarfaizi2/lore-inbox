Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVEBIeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVEBIeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 04:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbVEBIeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 04:34:19 -0400
Received: from smtpout4.uol.com.br ([200.221.4.195]:38886 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S261632AbVEBIeP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 04:34:15 -0400
Date: Mon, 2 May 2005 05:34:09 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.12-rc3-mm2
Message-ID: <20050502083409.GF5764@ime.usp.br>
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jesper Juhl <juhl-lkml@dif.dk>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
References: <20050501201145.GA14429@ime.usp.br> <Pine.LNX.4.62.0505012224350.2488@dragon.hyggekrogen.localhost> <1114994247.7111.347.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1114994247.7111.347.camel@gaston>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 02 2005, Benjamin Herrenschmidt wrote:
> > -	pte_unmap(pte);
> > +	pte_unmap((void *)pte);
> >  }
> >  
> >  static void smaps_pmd_range(pud_t *pud,
> 
> This is unrelated, and shouldn't be necessary. I don't lile patches that
> defeat typechecking. Of pte isn't a pte_t *, then something is wrong.

I just changed this to ptep (without the cast) and the kernel has been
successfully compiled. I will test it tomorrow morning.


Thanks for all the help, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
