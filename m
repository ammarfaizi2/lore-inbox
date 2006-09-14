Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWINLzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWINLzd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 07:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbWINLzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 07:55:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:9133 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751263AbWINLzc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 07:55:32 -0400
From: Andi Kleen <ak@suse.de>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [PATCH] i386/x86_64 signal handler arg fixes
Date: Thu, 14 Sep 2006 12:11:52 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>, hpa@zytor.com
References: <787b0d920609140134j5935c743kae4af8d51eea2a90@mail.gmail.com>
In-Reply-To: <787b0d920609140134j5935c743kae4af8d51eea2a90@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609141211.53087.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 September 2006 10:34, Albert Cahalan wrote:

> For i386, the non-RT frame is wrong. It was using the raw sig value
> instead of the translated value, and did not pass the semi-documented
> extra parameters.

The translation is not needed because x86-64 doesn't support iBCS at all
and afaik it was only used for that.

>
> For x86-64, the regparm 3 calling convention was simply missing.

Ok that should be added.

Can you please send a single patch that just does this?

-Andi

