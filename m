Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751181AbWHPQtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181AbWHPQtN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWHPQtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:49:13 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:31451 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751181AbWHPQtL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:49:11 -0400
Subject: Re: PATCH: Lock tty directly in acct layer
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <1155745460.3023.57.camel@laptopd505.fenrus.org>
References: <1155746201.24077.364.camel@localhost.localdomain>
	 <1155745460.3023.57.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 16 Aug 2006 18:09:54 +0100
Message-Id: <1155748194.24077.386.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-08-16 am 18:24 +0200, ysgrifennodd Arjan van de Ven:
> > -	read_lock(&tasklist_lock);	/* pin current->signal */
> > +	mutex_lock(&tty_mutex);
> >  	ac.ac_tty = current->signal->tty ?
> 
> but.. can't ->signal still change, even if signal->tty isn't ?

I'm not sure, thats a good question (as if so is how to lock it). Will
investigate.

