Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262029AbVEKTcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbVEKTcd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 15:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262030AbVEKTcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 15:32:33 -0400
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:51864 "EHLO
	mail-in-07.arcor-online.net") by vger.kernel.org with ESMTP
	id S262029AbVEKTcT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 15:32:19 -0400
Date: Wed, 11 May 2005 21:32:16 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Jamie Lokier <jamie@shareable.org>
cc: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>,
       Miklos Szeredi <miklos@szeredi.hu>, ericvh@gmail.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
In-Reply-To: <20050511170700.GC2141@mail.shareable.org>
Message-ID: <Pine.LNX.4.58.0505112121190.11888@be1.lrz>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it>
 <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it>
 <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org>
 <20050511170700.GC2141@mail.shareable.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2005, Jamie Lokier wrote:
> Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:

> > > How about a new clone option "CLONE_NOSUID"?
> > 
> > IMO, the clone call ist the wrong place to create namespaces. It should be
> > deprecated by a mkdir/chdir-like interface.
> 
> And the mkdir/chdir interface already exists, see "cd /proc/NNN/root".

If you want persistent namespaces, this will be a PITA (I don't want a 
keep-the-namespace-open-daemon), and if you don't, it will be racy 
(user a logs in, while his second/nth login expires).

Keeping a list of named namespaces in kernel can be made cheap and secure.
-- 
Friendly fire isn't. 
