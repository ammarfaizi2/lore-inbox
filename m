Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261407AbVDZLsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbVDZLsA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 07:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261475AbVDZLr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 07:47:59 -0400
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:7094 "EHLO
	mail-in-03.arcor-online.net") by vger.kernel.org with ESMTP
	id S261407AbVDZLr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 07:47:56 -0400
Date: Tue, 26 Apr 2005 13:46:56 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Jan Hudec <bulb@ucw.cz>
Cc: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>,
       Miklos Szeredi <miklos@szeredi.hu>,
       viro@parcelfarce.linux.theplanet.co.uk, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
In-Reply-To: <20050426090539.GB9131@vagabond>
Message-ID: <Pine.LNX.4.58.0504261339300.4555@be1.lrz>
References: <3WWn1-2ZC-3@gated-at.bofh.it> <3WWwR-3hT-35@gated-at.bofh.it>
 <3WWwU-3hT-49@gated-at.bofh.it> <3WWGj-3nm-3@gated-at.bofh.it>
 <3WWQ9-3uA-15@gated-at.bofh.it> <3WWZG-3AC-7@gated-at.bofh.it>
 <3X630-2qD-21@gated-at.bofh.it> <3X8HA-4IH-15@gated-at.bofh.it>
 <3Xagd-5Wb-1@gated-at.bofh.it> <E1DQ5LA-0003ZR-SM@be1.7eggert.dyndns.org>
 <20050426090539.GB9131@vagabond>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2005, Jan Hudec wrote:
> On Mon, Apr 25, 2005 at 17:17:35 +0200, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:

> > With attachable namespaces, the whole thing should be as simple as
> > (pseudocode)
> > mknamespace -p users/$UID # (like mkdir -p)
> > setnamespace users/$UID   # (like cd)
> 
> Well, yes and no. We should probably just have a syscall
> int join_namespace(pid_t pid)
> which would join the namespace process pid uses. And then have a PAM
> session module, that would attach the namespace of the first user's
> session (creating new namespace if this is the first session).

This will help for the fuse case, but since namespaces are hierarchical
(as I understand them), you can as well make the structure visible and
thereby turn a feature for one user into a feature for general use.
-- 
Programming is an art form that fights back. 
