Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWAXSRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWAXSRS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 13:17:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWAXSRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 13:17:18 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63704 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932478AbWAXSRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 13:17:17 -0500
Date: Tue, 24 Jan 2006 18:17:12 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Joe Korty <joe.korty@ccur.com>
Cc: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Define __raw_read_lock etc for uniprocessor builds
Message-ID: <20060124181712.GA13277@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Joe Korty <joe.korty@ccur.com>, mingo@elte.hu, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20060124180954.GA14506@tsunami.ccur.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124180954.GA14506@tsunami.ccur.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 01:09:54PM -0500, Joe Korty wrote:
> 
> Make NOPed versions of __raw_read_lock and family available
> under uniprocessor kernels.
> 
> Discovered when compiling a uniprocessor kernel with the
> fusyn patch applied.
> 
> The standard kernel does not use __raw_read_lock etc
> outside of spinlock.c, which may account for this bug
> being undiscovered until now.

No one should call these directly.   Please fix your odd patch instead.

