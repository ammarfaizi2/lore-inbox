Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263658AbTENS7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 14:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263660AbTENS7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 14:59:22 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:1672 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S263658AbTENS7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 14:59:21 -0400
Date: Wed, 14 May 2003 15:11:53 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Dave McCracken <dmccr@us.ibm.com>
cc: Andrew Morton <akpm@digeo.com>, <mika.penttila@kolumbus.fi>,
       <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Race between vmtruncate and mapped areas?
In-Reply-To: <127820000.1052939265@baldur.austin.ibm.com>
Message-ID: <Pine.LNX.4.44.0305141511270.10617-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 May 2003, Dave McCracken wrote:
> --On Wednesday, May 14, 2003 15:04:55 -0400 Rik van Riel <riel@redhat.com>
> wrote:
> 
> >> Not to mention they could end up being outside of any VMA,
> >> meaning there's no sane way to deal with them.
> > 
> > I hate to follow up to my own email, but the fact that
> > they're not in any VMA could mean we leak these pages
> > at exit() time.
> 
> Well, they are still inside the vma.  Truncate doesn't shrink the vma.  It
> just generates SIGBUS when the app tries to fault the pages in.

Right, I forgot about that.  Forget the memory leak and
security bug theory, then ;)))

