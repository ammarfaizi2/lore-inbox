Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbVHJXqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbVHJXqT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 19:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932608AbVHJXqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 19:46:19 -0400
Received: from graphe.net ([209.204.138.32]:35241 "EHLO graphe.net")
	by vger.kernel.org with ESMTP id S932610AbVHJXqT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 19:46:19 -0400
Date: Wed, 10 Aug 2005 16:46:16 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@graphe.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
       kiran@scalex86.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: [PATCH] ide-disk oopses on boot
In-Reply-To: <1123686298.28913.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0508101645460.24056@graphe.net>
References: <20050809132725.GA20397@vana.vc.cvut.cz> 
 <Pine.LNX.4.62.0508090926150.12719@graphe.net>  <42F92A1F.9040901@vc.cvut.cz>
  <Pine.LNX.4.62.0508091953270.30717@graphe.net> <1123686298.28913.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -5.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Alan Cox wrote:

> On Maw, 2005-08-09 at 19:59 -0700, Christoph Lameter wrote:
> > Yes you are right there is one additional place where pcibus_to_node is 
> > used with the hwif that we did not cover. This better go into 2.6.13.
> 
> drive->hwif is not permitted to be NULL. Please work back and fix the
> actual bug.

The actual bug was fixed. The description was wrong. We are not checking 
hwif but hwif->pci_dev.
 
