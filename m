Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757089AbWK0GgB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757089AbWK0GgB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 01:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757090AbWK0GgB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 01:36:01 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:45207 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1757088AbWK0GgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 01:36:01 -0500
Date: Mon, 27 Nov 2006 06:35:58 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       Stephen Smalley <sds@tycho.nsa.gov>, James Morris <jmorris@namei.org>,
       viro@zeniv.linux.org.uk
Subject: Re: [PATCH] selinux: fix dentry_open() error check
Message-ID: <20061127063558.GA6688@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
	Stephen Smalley <sds@tycho.nsa.gov>,
	James Morris <jmorris@namei.org>, viro@zeniv.linux.org.uk
References: <20061127061648.GA20065@APFDCB5C>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127061648.GA20065@APFDCB5C>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 03:16:48PM +0900, Akinobu Mita wrote:
> The return value of dentry_open() shoud be checked by IS_ERR().

first great work finding all these calling convetion mismatches.

Do you have some tool to find these?

I wonder whether we should have some form of sparse annotation to
tell that a function returns these kinds of errors and we either
need to check IS_ERR or returned it again a caller with the same attribute.
