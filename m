Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWFUVE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWFUVE0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030307AbWFUVE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:04:26 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47236 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030300AbWFUVEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:04:25 -0400
Subject: Re: [PATCH -mm 1/6] cpu_relax(): interrupt.h
From: Arjan van de Ven <arjan@infradead.org>
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Cc: Andrew Morton <akpm@osdl.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060621205932.GA22516@rhlx01.fht-esslingen.de>
References: <20060621205932.GA22516@rhlx01.fht-esslingen.de>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 23:04:20 +0200
Message-Id: <1150923860.3057.116.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-06-21 at 22:59 +0200, Andreas Mohr wrote:
> Add cpu_relax() to tasklet_unlock_wait() loop.
> 
> 
> I kept barrier() since it is said to still be required, in various older
> postings.

cpu_relax() includes a barrier always, per definition.
(simply because anywhere you would use cpu_relax() you would also put a
barrier)


