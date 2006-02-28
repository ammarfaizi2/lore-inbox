Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751887AbWB1BWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751887AbWB1BWd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 20:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751888AbWB1BWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 20:22:33 -0500
Received: from cantor2.suse.de ([195.135.220.15]:15512 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751887AbWB1BWc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 20:22:32 -0500
From: Andi Kleen <ak@suse.de>
To: Richard Henderson <rth@redhat.com>
Subject: Re: [patch] i386: make bitops safe
Date: Tue, 28 Feb 2006 02:24:13 +0100
User-Agent: KMail/1.9.1
Cc: Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
References: <200602271700_MC3-1-B969-F4A5@compuserve.com> <200602280047.22909.ak@suse.de> <20060228005436.GA24895@redhat.com>
In-Reply-To: <20060228005436.GA24895@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602280224.13632.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 February 2006 01:54, Richard Henderson wrote:

> I think the best argument for simply leaving things with a memory
> clobber is that these are atomic operations, and are on occasion
> used as locks, or parts of locks.

How about __set_bit? It is supposed to be not atomic. What would
be best there?

-Andi
