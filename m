Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132934AbREBMsq>; Wed, 2 May 2001 08:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133012AbREBMsg>; Wed, 2 May 2001 08:48:36 -0400
Received: from bacchus.veritas.com ([204.177.156.37]:16779 "EHLO
	bacchus-int.veritas.com") by vger.kernel.org with ESMTP
	id <S132934AbREBMsa>; Wed, 2 May 2001 08:48:30 -0400
Date: Wed, 2 May 2001 13:49:16 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "J . A . Magallon" <jamagallon@able.es>,
        Wakko Warner <wakko@animx.eu.org>,
        Xavier Bestel <xavier.bestel@free.fr>,
        Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <20010502120403.G26638@redhat.com>
Message-ID: <Pine.LNX.4.21.0105021343490.1776-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 May 2001, Stephen C. Tweedie wrote:
> 
> So the aim is more complex.  Basically, once we are short on VM, we
> want to eliminate redundant copies of swap data.  That implies two
> possible actions, not one --- we can either remove the swap page for
> data which is already in memory, or we can remove the in-memory copy
> of data which is already on swap.  Which one is appropriate will
> depend on whether the ptes in the system point to the swap entry or
> the memory entry.  If we have ptes pointing to both, then we cannot
> free either.

Sorry for stating the obvious, but that last sentence gives up too easily.
If we have ptes pointing to both, then we cannot free either until we have
replaced all the references to one by references to the other.

Hugh

