Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVEUNoN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVEUNoN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 09:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVEUNoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 09:44:13 -0400
Received: from mail.shareable.org ([81.29.64.88]:16090 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261420AbVEUNoI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 09:44:08 -0400
Date: Sat, 21 May 2005 14:43:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ram <linuxram@us.ibm.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC][PATCH] rbind across namespaces
Message-ID: <20050521134358.GA4274@mail.shareable.org>
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1116660380.4397.66.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram wrote:
> > Also why check current->namespace?  It doesn't hurt to do
> > get_namespace() even if it's not strictly needed.  And it would
> > simplify the code.
> 
> however get_namespace() will chew up some extra cycles
> sometimes unnecessarily. I did incorporate your comment and
> got much simpler code.

Checking current->namespace also chews up extra cycles, sometimes
unnecessarily, but the cycles are negligable in both cases.

Because they're negligable, the most important thing is to avoid
unnecessary complications in the code.

-- Jamie
