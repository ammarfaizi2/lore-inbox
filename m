Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbWD0G3A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbWD0G3A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 02:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWD0G3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 02:29:00 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:2520 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964963AbWD0G27
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 02:28:59 -0400
Date: Thu, 27 Apr 2006 09:28:58 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Bart Hartgers <bart@etpmod.phys.tue.nl>,
       "=?ISO-8859-1?Q?J=F6rn_Engel?=" <joern@wohnheim.fh-wedel.de>,
       Arjan van de Ven <arjan@infradead.org>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] likely cleanup: remove unlikely for kfree(NULL)
In-Reply-To: <CB27C57D-BABF-4900-9299-F342861CF1E0@mac.com>
Message-ID: <Pine.LNX.4.58.0604270928170.20454@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.64.0604251120420.5810@localhost.localdomain>
 <84144f020604260030v26f42b0bke639053928d5e471@mail.gmail.com>
 <1146038324.5956.0.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0604261112120.3522@sbz-30.cs.Helsinki.FI>
 <1146040038.7016.0.camel@laptopd505.fenrus.org> <20060426100559.GC29108@wohnheim.fh-wedel.de>
 <1146046118.7016.5.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.58.0604261354310.9797@sbz-30.cs.Helsinki.FI>
 <1146049414.7016.9.camel@laptopd505.fenrus.org> <20060426110656.GD29108@wohnheim.fh-wedel.de>
 <444F5B74.60809@etpmod.phys.tue.nl> <444F6FDD.7040000@etpmod.phys.tue.nl>
 <CB27C57D-BABF-4900-9299-F342861CF1E0@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2006, Kyle Moffett wrote:
> Here's code that I've found works as well as can be expected under both GCC 3
> and GCC 4.  If xp is a known-NULL constant the whole function will be
> optimized out completely.  If xp is known-not-NULL, then it will optimize to a
> kfree function without the null check.  Otherwise it optimizes to call the
> out-of-line version.

Wouldn't it be better to simply remove calls to kfree() with known 
NULL constant?

				Pekka
