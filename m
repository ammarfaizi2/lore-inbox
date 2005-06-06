Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVFFLne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVFFLne (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 07:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVFFLne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 07:43:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:25810 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261181AbVFFLnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 07:43:33 -0400
Date: Mon, 6 Jun 2005 12:43:24 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jan Blunck <j.blunck@tu-harburg.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] don't allow sys_readahead() on files opened with O_DIRECT
Message-ID: <20050606114324.GA7774@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Blunck <j.blunck@tu-harburg.de>, Andrew Morton <akpm@osdl.org>,
	Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <42A435DE.50302@tu-harburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42A435DE.50302@tu-harburg.de>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

your check is wrong, it's testing whether the filesystem supports O_DIRECT, not
whether sys_readahead is used on a file descriptor that has been opened with O_DIRECT
