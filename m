Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965019AbVHSQmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965019AbVHSQmu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 12:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932593AbVHSQmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 12:42:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:13454 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932554AbVHSQmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 12:42:49 -0400
Date: Fri, 19 Aug 2005 17:42:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, James.Bottomley@SteelEye.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.6.13-rc6-mm1: drivers/scsi/aic7xxx/ compile error
Message-ID: <20050819164241.GA4056@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20050819043331.7bc1f9a9.akpm@osdl.org> <20050819164036.GE3682@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050819164036.GE3682@stusta.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2005 at 06:40:36PM +0200, Adrian Bunk wrote:
> <--  snip  -->
> 
> ...
>   LD      drivers/scsi/aic7xxx/built-in.o
> drivers/scsi/aic7xxx/aic79xx.o: In function `aic_parse_brace_option':
> : multiple definition of `aic_parse_brace_option'
> drivers/scsi/aic7xxx/aic7xxx.o:: first defined here
> make[3]: *** [drivers/scsi/aic7xxx/built-in.o] Error 1
> 
> <--  snip  -->
> 
> 
> #includ'ing .c files is considered harmful...

That code previously had a hack to rename those that I removed
accidentally.  I think we should just kill aiclib.c and keep two
copies of the two functions it still has - they'll go away soon anyway.
I'll cook up a patch and sent it to James ASAP.

