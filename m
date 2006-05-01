Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWEAGiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWEAGiO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 02:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWEAGiO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 02:38:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:8079 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751285AbWEAGiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 02:38:13 -0400
Subject: Re: [PATCH/RFC] minix filesystem update to V3 for 2.6 kernels
From: Arjan van de Ven <arjan@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Daniel =?ISO-8859-1?Q?Aragon=E9s?= <danarag@gmail.com>,
       penberg@cs.helsinki.fi, linux-kernel@vger.kernel.org
In-Reply-To: <20060430134527.5175661a.akpm@osdl.org>
References: <4454C131.8070309@gmail.com>
	 <20060430134527.5175661a.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 01 May 2006 08:38:04 +0200
Message-Id: <1146465484.20760.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > @@ -79,24 +96,35 @@
> >  int minix_new_block(struct inode * inode)
> >  {
> >  	struct minix_sb_info *sbi = minix_sb(inode->i_sb);
> > -	int i;
> > +	char *offset = kmalloc(sizeof(char *), GFP_KERNEL);
> 
> That's a peculiar thing to do.


yeah it should it least be GFP_NOFS probably ;)

