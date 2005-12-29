Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964955AbVL2LDv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964955AbVL2LDv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 06:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVL2LDv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 06:03:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:39086 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932585AbVL2LDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 06:03:50 -0500
Subject: Re: [patch] updates XFS mutex patch
From: Arjan van de Ven <arjan@infradead.org>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Ingo Molnar <mingo@elte.hu>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <yq0zmmktbhk.fsf@jaguar.mkp.net>
References: <yq0zmmktbhk.fsf@jaguar.mkp.net>
Content-Type: text/plain
Date: Thu, 29 Dec 2005 12:03:42 +0100
Message-Id: <1135854222.2935.15.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-29 at 05:59 -0500, Jes Sorensen wrote:

> +
> +#define xfs_mutex_init(lock, type, name)	mutex_init(lock)
> +#define xfs_mutex_lock(lock, type)		mutex_lock(lock)
> +#define mutex_destroy(lock)			do{}while(0)

why not just change all mutex_init users to only pass lock? (same for
the others) eg why add another abstraction instead of fixing the caller?

