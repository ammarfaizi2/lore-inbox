Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261794AbVDEQR5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261794AbVDEQR5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:17:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVDEQR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:17:57 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:43168 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261794AbVDEQQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:16:23 -0400
Date: Tue, 5 Apr 2005 18:16:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: David Howells <dhowells@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to cast pointer to (void *) when passing it to kfree()
Message-ID: <20050405161624.GC12536@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.62.0504042326220.2496@dragon.hyggekrogen.localhost> <26741.1112695498@redhat.com> <Pine.LNX.4.62.0504051238410.15967@jjulnx.backbone.dif.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.62.0504051238410.15967@jjulnx.backbone.dif.dk>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 April 2005 12:39:44 +0200, Jesper Juhl wrote:
> On Tue, 5 Apr 2005, David Howells wrote:
> > Jesper Juhl <juhl-lkml@dif.dk> wrote:
> > 
> > > kfree() takes a void pointer argument, no need to cast.
> > 
> > vma->vm_start is unsigned long (unless it's changed since last I looked):
> > 
> As I wrote in the reply I send to my original mail I made a stupid 
> mistake. Don't know what I was thinking. Sorry.

Your thinking wasn't that bad, just didn't match the language.  As
Linus already noted, C could use a truly transparent data type, for
things like kmalloc, kfree, or the various ->private_data fields in
structs.

Jörn

-- 
The cost of changing business rules is much more expensive for software
than for a secretaty.
-- unknown
