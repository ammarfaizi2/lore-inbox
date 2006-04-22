Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbWDVW6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbWDVW6S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 18:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWDVW6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 18:58:18 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.43]:14053 "EHLO
	smtprelay05.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751217AbWDVW6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 18:58:17 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Shrink rbtree
Date: Sun, 23 Apr 2006 00:55:55 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, andrea@suse.de,
       linux-kernel@vger.kernel.org
References: <1145623663.11909.139.camel@pmac.infradead.org> <200604221429.27858.ioe-lkml@rameria.de> <1145713139.11909.262.camel@pmac.infradead.org>
In-Reply-To: <1145713139.11909.262.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604230055.56207.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hio David,

On Saturday, 22. April 2006 15:38, David Woodhouse wrote:
> I'm reluctant to 'bless' this practice, because we'll then get asked to
> set it to 'inactive' every time we take a node off the tree, to have a
> BUG_ON() which checks it in certain places, etc.... it's mostly
> pointless AFAICT.

I understand your point. Can we agree on just doing this for functions which
are handed off-tree and on-tree nodes and have to care for locking reasons?

It is ok for functions to enforce their API with BUG_ON(). But this part should
not be generalized, since this part really depends on the user.

Each rbtree user having its own private hackery for this is wasted developer
resources IMHO. 

So please either provide common helpers or just delete the potential users
if you think this is not needed.

I'm happy either way.


Regards

Ingo Oeser
