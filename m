Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVAXMRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVAXMRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbVAXMRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 07:17:33 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:33155 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261233AbVAXMRc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 07:17:32 -0500
Date: Mon, 24 Jan 2005 12:17:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>, rml@novell.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050124121729.GA29392@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, rml@novell.com,
	linux-kernel@vger.kernel.org
References: <20050124021516.5d1ee686.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050124021516.5d1ee686.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> inotify.patch
>   inotify

Haven't had time to look at the current implementation, but the in-kernel
interface is still horrible as it duplicates the dnotify calls all over the
place, using IN_FOO instead of DN_FOO.  Please add a layer of notify_foo
wrappers that calls into both.

Also ioctl is not an acceptable interface for adding new core functionality.
