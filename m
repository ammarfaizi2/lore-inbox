Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265997AbUGEKSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265997AbUGEKSK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 06:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbUGEKSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 06:18:10 -0400
Received: from [213.146.154.40] ([213.146.154.40]:22490 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S265997AbUGEKSJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 06:18:09 -0400
Date: Mon, 5 Jul 2004 11:18:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm6
Message-ID: <20040705101804.GA14866@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, neilb@cse.unsw.edu.au,
	linux-kernel@vger.kernel.org
References: <20040705023120.34f7772b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040705023120.34f7772b.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +use-llseek-instead-of-f_pos=-for-directory-seeking.patch
> 
>  Fix an nfsd problem when the client sends an insane directory offset.

Please either use llseek() directly or renamed the thing to vfs_llseek()
everywhere.  Two names for exactly the same thing are a bad idea.

(The latter sounds like the better idea to me)
