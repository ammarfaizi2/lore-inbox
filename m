Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267738AbUGWQTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267738AbUGWQTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 12:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267820AbUGWQTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 12:19:17 -0400
Received: from [213.146.154.40] ([213.146.154.40]:10636 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S267738AbUGWQR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 12:17:28 -0400
Date: Fri, 23 Jul 2004 17:17:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: maximilian attems <janitor@sternwelten.at>
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: Re: [patch-kj] use list_for_each() in fs/jffs/intrep.c
Message-ID: <20040723161724.GA31884@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	maximilian attems <janitor@sternwelten.at>, jffs-dev@axis.com,
	linux-kernel@vger.kernel.org
References: <20040723155528.GQ1795@stro.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040723155528.GQ1795@stro.at>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 05:55:28PM +0200, maximilian attems wrote:
> 
> Use list_for_each() where applicable
> - for (list = ymf_devs.next; list != &ymf_devs; list = list->next) {
> + list_for_each(list, &ymf_devs) {
> pure cosmetic change, defined as a preprocessor macro in:
> include/linux/list.h
> 
> applies cleanly to 2.6.8-rc2
> 
> From: Domen Puncer <domen@coderock.org>
> Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

Please switch to list_for_each_entry while you're at it.
