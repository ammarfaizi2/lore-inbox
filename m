Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbWH2Lp3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbWH2Lp3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964955AbWH2Lp3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:45:29 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36778 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964950AbWH2Lp2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:45:28 -0400
Date: Tue, 29 Aug 2006 12:45:02 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       Richard Knutsson <ricknu-0@student.ltu.se>,
       James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Conversion to generic boolean
Message-ID: <20060829114502.GD4076@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>,
	Richard Knutsson <ricknu-0@student.ltu.se>,
	James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <44EFBEFA.2010707@student.ltu.se> <20060828093202.GC8980@infradead.org> <20060828171804.09c01846.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060828171804.09c01846.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2006 at 05:18:04PM -0700, Andrew Morton wrote:
> At present we have >50 different definitions of TRUE and gawd knows how
> many private implementations of various flavours of bool.
> 
> In that context, Richard's approach of giving the kernel a single
> implementation of bool/true/false and then converting things over to use it
> makes sense.  The other approach would be to go through and nuke the lot,
> convert them to open-coded 0/1.
> 
> I'm not particularly fussed either way, really.  But the present situation
> is nuts.

Let's start to kill all those utterly silly if (x == true) and if (x == false)
into if (x) and if (!x) and pospone the type decision.  Adding a bool type
only makes sense if we have any kind of static typechecking that no one
ever assign an invalid type to it.
