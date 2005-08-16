Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbVHPJSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbVHPJSD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 05:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965162AbVHPJSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 05:18:01 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:14759 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965160AbVHPJSA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 05:18:00 -0400
Date: Tue, 16 Aug 2005 10:17:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>
Subject: Re: [PATCH 2.6.13-rc6] remove dead reset function from cpqfcTS driver
Message-ID: <20050816091758.GA21378@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org,
	James Bottomley <James.Bottomley@steeleye.com>,
	Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
	Bolke de Bruin <bdbruin@aub.nl>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508091806.45341@bilbo.math.uni-mannheim.de> <200508161111.08070@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508161111.08070@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 11:11:06AM +0200, Rolf Eike Beer wrote:
> cpqfcTS_reset() is never referenced from anywhere. By using the nonexistent 
> constant SCSI_RESET_ERROR it causes just another unneeded compile error.

That was the old reset handler.  Do you actually have this hardware?
The driver is pretty much un-recoverable and mkp is working on a from
scratch driver for this hardware - I don't think putting any work into the
driver makes sense unless you have a very urgent need to use it.

