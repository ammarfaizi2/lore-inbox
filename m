Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261271AbULSNgM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbULSNgM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 08:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261289AbULSNgL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 08:36:11 -0500
Received: from [213.146.154.40] ([213.146.154.40]:30444 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261271AbULSNgK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 08:36:10 -0500
Date: Sun, 19 Dec 2004 13:36:07 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Ondrej Zary <linux@rainbow-software.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] cdu31a - more fixes
Message-ID: <20041219133607.GA599@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ondrej Zary <linux@rainbow-software.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <41C4BD54.2060703@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C4BD54.2060703@rainbow-software.org>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define RETURN_UP(retval) do {up(&sony_sem); return (retval);} while(0)

Please don't use such obsfucation macros.  Instead use gotos in the
functions to haev a single exit path that releases the lock.

