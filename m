Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWDZKIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWDZKIm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 06:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751420AbWDZKIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 06:08:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6035 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751398AbWDZKIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 06:08:42 -0400
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
From: Arjan van de Ven <arjan@infradead.org>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Pekka J Enberg <penberg@cs.Helsinki.FI>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060426100559.GC29108@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
	 <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
	 <1146038324.5956.0.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI>
	 <1146040038.7016.0.camel@laptopd505.fenrus.org>
	 <20060426100559.GC29108@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Apr 2006 12:08:37 +0200
Message-Id: <1146046118.7016.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-26 at 12:05 +0200, Jörn Engel wrote:
> On Wed, 26 April 2006 10:27:18 +0200, Arjan van de Ven wrote:
> > 
> > what I would like is kfree to become an inline wrapper that does the
> > null check inline, that way gcc can optimize it out (and it will in 4.1
> > with the VRP pass) if gcc can prove it's not NULL.
> 
> How well can gcc optimize this case? 

if you deref'd the pointer it'll optimize it away (assuming a new enough
gcc, like 4.1)


