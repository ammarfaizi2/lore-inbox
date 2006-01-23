Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWAWSBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWAWSBM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbWAWSBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:01:11 -0500
Received: from mail.gmx.de ([213.165.64.21]:30150 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S964854AbWAWSBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:01:11 -0500
X-Authenticated: #428038
Date: Mon, 23 Jan 2006 19:01:06 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Rationale for RLIMIT_MEMLOCK?
Message-ID: <20060123180106.GA4879@merlin.emma.line.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
References: <20060123105634.GA17439@merlin.emma.line.org> <1138014312.2977.37.camel@laptopd505.fenrus.org> <20060123165415.GA32178@merlin.emma.line.org> <1138035602.2977.54.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138035602.2977.54.camel@laptopd505.fenrus.org>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2006, Arjan van de Ven wrote:

> yes the behavior is like this
> 
>                  root                non-root
> before        about half of ram      nothing
> after         all of ram             by default small, increasable
> [...]
> What application do you have in mind that broke by this relaxing of
> rules?

This is not something I'd like to disclose here yet.

It is an application that calls mlockall(MCL_CURRENT|MCL_FUTURE) and
apparently copes with mlockall() returning EPERM (or doesn't even try
it) but can apparently NOT cope with valign() tripping over mmap() ==
-1/EAGAIN.

The relevant people are Bcc:d.

-- 
Matthias Andree
