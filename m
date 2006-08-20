Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750941AbWHTQra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750941AbWHTQra (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 12:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWHTQra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 12:47:30 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:51126
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S1750901AbWHTQra
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 12:47:30 -0400
From: Michael Buesch <mb@bu3sch.de>
To: Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Date: Sun, 20 Aug 2006 18:47:05 +0200
User-Agent: KMail/1.9.1
References: <20060820003840.GA17249@openwall.com> <1156089203.23756.46.camel@laptopd505.fenrus.org> <44E88DC3.7000708@redhat.com>
In-Reply-To: <44E88DC3.7000708@redhat.com>
Cc: Solar Designer <solar@openwall.com>,
       Alex Riesen <fork0@users.sourceforge.net>,
       Willy Tarreau <wtarreau@hera.kernel.org>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608201847.05707.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 August 2006 18:28, Ulrich Drepper wrote:
> Arjan van de Ven wrote:
> > sounds like a good argument to get the setuid functions marked
> > __must_check in glibc...
> 
> There are too many false positives.  E.g., in a SUID binaries switching
> back from a non-root UID to root will not fail.  Very common.

Well, I would say it clearly depends on the actual kernel
implementation if that can fail or not.
So userspace should really always check.

-- 
Greetings Michael.
