Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWDZKGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWDZKGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 06:06:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWDZKGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 06:06:06 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:30342 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751398AbWDZKGF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 06:06:05 -0400
Date: Wed, 26 Apr 2006 12:05:59 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
Message-ID: <20060426100559.GC29108@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain> <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com> <1146038324.5956.0.camel@laptopd505.fenrus.org> <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI> <1146040038.7016.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1146040038.7016.0.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 April 2006 10:27:18 +0200, Arjan van de Ven wrote:
> 
> what I would like is kfree to become an inline wrapper that does the
> null check inline, that way gcc can optimize it out (and it will in 4.1
> with the VRP pass) if gcc can prove it's not NULL.

How well can gcc optimize this case?  I guess the effect on text size
of such a patch may give an indication.

Jörn

-- 
A victorious army first wins and then seeks battle.
-- Sun Tzu
