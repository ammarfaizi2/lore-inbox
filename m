Return-Path: <linux-kernel-owner+w=401wt.eu-S1422963AbWLUQ3p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422963AbWLUQ3p (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 11:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422869AbWLUQ3p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 11:29:45 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:49263 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422960AbWLUQ3o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 11:29:44 -0500
Subject: Re: fuse, get_user_pages, flush_anon_page, aliasing caches and all
	that again
From: Arjan van de Ven <arjan@infradead.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-arch <linux-arch@vger.kernel.org>,
       Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <20061221152621.GB3958@flint.arm.linux.org.uk>
References: <20061221152621.GB3958@flint.arm.linux.org.uk>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 21 Dec 2006 17:29:42 +0100
Message-Id: <1166718582.3365.1509.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.2.1 (2.8.2.1-2.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, given all this additional complexity _and_ that it would only be
> safe on non-preempt UP, the question becomes: is using get_user_pages()
> to access the current processes memory space legal?  Given the above,
> I would say not.

I'd say that copy_from_user is the right api for this, not
get_user_pages + kmap hacks...


-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

