Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312393AbSD2ObT>; Mon, 29 Apr 2002 10:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312411AbSD2ObS>; Mon, 29 Apr 2002 10:31:18 -0400
Received: from vti01.vertis.nl ([145.66.4.26]:63250 "EHLO vti01.vertis.nl")
	by vger.kernel.org with ESMTP id <S312393AbSD2ObR>;
	Mon, 29 Apr 2002 10:31:17 -0400
Message-Id: <200204291430.g3TEUiV02444@fokkensr.vertis.nl>
Content-Type: text/plain; charset=US-ASCII
From: Rolf Fokkens <fokkensr@linux06.vertis.nl>
To: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
Subject: Re: [PATCH] module locking
Date: Mon, 29 Apr 2002 09:30:07 +0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.GSO.4.05.10204290922080.21672-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 April 2002 09:23, Thomas 'Dent' Mirlacher wrote:
> the capable call is sthell there, but with the module_lock
> kind or redundant.

once set module_lock cannot be cleared, not even by root. This differs from 
the CAP_SYS_MODULE which can be activated by root, if I'm correct.

module_lock is only a suggestion, w/o /dev/kmem write locking or even locking 
writes on other /dev/.. or doing mounts it won't be full proof.

