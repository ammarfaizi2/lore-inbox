Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbVEUNqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbVEUNqk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 09:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbVEUNqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 09:46:37 -0400
Received: from mail.shareable.org ([81.29.64.88]:17882 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261356AbVEUNq0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 09:46:26 -0400
Date: Sat, 21 May 2005 14:46:15 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] rbind across namespaces
Message-ID: <20050521134615.GB4274@mail.shareable.org>
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> I still see a problem: what if old_nd.mnt is already detached, and
> bind is non-recursive.  Now it fails with EINVAL, though it used to
> work (and I think is very useful).

Hey, you just made another argument for not detaching mounts when the
last task with that current->namespace exits, but instead detaching
mounts when the last reference to any vfsmnt in the namespace is dropped.

Hint :)

-- Jamie
