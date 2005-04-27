Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbVD0U6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbVD0U6k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:58:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVD0U6j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:58:39 -0400
Received: from mail.dif.dk ([193.138.115.101]:43419 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S262009AbVD0U5Y convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:57:24 -0400
Date: Wed, 27 Apr 2005 23:00:45 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: =?ISO-8859-1?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Cc: linux-kernel@vger.kernel.org, mj@ucw.cz
Subject: Re: [PATCH] 2.4.30 PicoPower IRQ router
In-Reply-To: <426FD8C7.5080800@molgaard.org>
Message-ID: <Pine.LNX.4.62.0504272250300.2481@dragon.hyggekrogen.localhost>
References: <426C9DED.9010206@molgaard.org> <200504261740.08794.lists@b-open-solutions.it>
 <426E8FE4.5040307@molgaard.org> <20050427112850.GA18533@nd47.coderock.org>
 <426FD8C7.5080800@molgaard.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few more style comments below. Nice cleanup compared to the first 
version though. Now let's get it perfect :-)

On Wed, 27 Apr 2005, Sune Mølgaard wrote:

> Domen Puncer wrote:
> > On 26/04/05 21:00 +0200, Sune Mølgaard wrote:
> > 
> > Signed-off-by? And weird indentification, try to use tabs.
> > 
> 
> Signed-off-by Sune Molgaard sune@molgaard.org

Proper form would be:  Signed-off-by: Sune Molgaard <sune@molgaard.org>


> +static int pirq_pico_set(struct pci_dev *router, struct pci_dev *dev, int
> pirq, int irq)
> +{
> +        outb(0x10+((pirq-1)>>1), 0x24);
   ^^^^^^^^
   Proper indentation depth (8 chars)

> +       unsigned int x;
   ^^^^^^^
   Only 7 char indentation.

This mismatch is found several places in the patch. Besides, the patch 
seems whitespace damaged - the lines seem to be indented with spaces, not 
tabs. Perhaps your email client mangled it?

(note: Chapter 1 of Documentation/CodingStyle describes proper 
 indentation)


> +        switch(device)
> +       {

The opening brace goes on the same line as the switch statement.

See Documentation/CodingStyle Chapter 2


-- 
Jesper Juhl


