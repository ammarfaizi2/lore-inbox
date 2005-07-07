Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261812AbVGGTP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbVGGTP3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 15:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262074AbVGGTN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 15:13:58 -0400
Received: from graphe.net ([209.204.138.32]:8070 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S261946AbVGGTJG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 15:09:06 -0400
Date: Thu, 7 Jul 2005 12:09:00 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Linus Torvalds <torvalds@osdl.org>
cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Andi Kleen <ak@suse.de>,
       linux-ide@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [another PATCH] Fix crash on boot in kmalloc_node IDE changes
In-Reply-To: <Pine.LNX.4.58.0507071154440.3293@g5.osdl.org>
Message-ID: <Pine.LNX.4.62.0507071208210.8200@graphe.net>
References: <20050706133052.GF21330@wotan.suse.de> <Pine.LNX.4.62.0507070912140.27066@graphe.net>
 <Pine.LNX.4.58.0507070937130.3293@g5.osdl.org> <Pine.LNX.4.62.0507071022480.7105@graphe.net>
 <Pine.LNX.4.58.0507071154440.3293@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Jul 2005, Linus Torvalds wrote:

> Yes. Except that if hwif is NULL, we'll have other oopses since we access 
> that in other places.
> 
> Why _is_ hwif NULL anyway? That's another, unrelated thing, and should 
> probably have a separate check and an early return.

I was wondering about that one as well. Andi brought it up.
