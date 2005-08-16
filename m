Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030223AbVHPQY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030223AbVHPQY7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 12:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030222AbVHPQY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 12:24:59 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:21466 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030220AbVHPQY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 12:24:58 -0400
Date: Tue, 16 Aug 2005 17:24:57 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Bolke de Bruin <bdbruin@aub.nl>
Subject: Re: [PATCH 2.6.13-rc6] improve start/stop code for worker thread in cpqfcTS driver, take 2
Message-ID: <20050816162457.GA29799@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Rolf Eike Beer <eike-kernel@sf-tec.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-scsi@vger.kernel.org,
	James Bottomley <James.Bottomley@steeleye.com>,
	Bolke de Bruin <bdbruin@aub.nl>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508161114.39675@bilbo.math.uni-mannheim.de> <200508161658.15546@bilbo.math.uni-mannheim.de> <200508161820.57817@bilbo.math.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508161820.57817@bilbo.math.uni-mannheim.de>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2005 at 06:20:56PM +0200, Rolf Eike Beer wrote:
> Use pid of worker thread and struct completion for signaling end of worker 
> thread (code more or less taken from drivers/net/8139too.c). For the moment 
> the return code of the start/stop functions is ignored, this will change 
> once the init/exit code is changed to use 2.6 driver model.

thread start/stop should use the kthread.h API.  Not that this helps at
all for this driver..

