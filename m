Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWGJOu6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWGJOu6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422643AbWGJOu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:50:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:43729 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1422642AbWGJOu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:50:58 -0400
Date: Mon, 10 Jul 2006 15:50:56 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 5/9] -Wshadow: variables named 'up' clash with up()
Message-ID: <20060710145056.GA549@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
References: <200607101313.04275.jesper.juhl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200607101313.04275.jesper.juhl@gmail.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -static inline void uid_hash_insert(struct user_struct *up, struct list_head *hashent)
> +static inline void uid_hash_insert(struct user_struct *_up, struct list_head *hashent)
>  {

Please never use such ugly names.  A simply 'u' as variable name would do it
instead in most places.

