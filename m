Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261276AbVBZT7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbVBZT7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 14:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261277AbVBZT7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 14:59:45 -0500
Received: from mx2.mail.ru ([194.67.23.122]:36706 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S261281AbVBZT72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 14:59:28 -0500
From: Alexey Dobriyan <adobriyan@mail.ru>
To: Eric Gaumer <gaumerel@ecs.fullerton.edu>
Subject: Re: [PATCH] orinoco rfmon
Date: Sat, 26 Feb 2005 22:59:30 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, proski@gnu.org, hermes@gibson.dropbear.id.au
References: <4220BB87.2010806@ecs.fullerton.edu>
In-Reply-To: <4220BB87.2010806@ecs.fullerton.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200502262259.30897.adobriyan@mail.ru>
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 26 February 2005 20:10, Eric Gaumer wrote:

> If the code looks problematic could someone point out possible
> deficiencies so we can work toward a satisfactory resolution? I didn't
> write the code but I'm willing do what I have to in order to get this
> (wireless scanning) into the official tree. 

Uhhh... Started to comment line-by-line but then realized it would take too
much time.

* Read Documentaion/CodingStyle.
* Indent code with tabs where it is already indented with tabs.
* Brackets around a single number in #define's are useless.
* Use u8, u16, u32 (not uint*_t) where the code already uses them.
* Comments are supposed to be anonymous.
* Use appropriate KERN_* constant in printk()'s.
* Don't pack simple types (uint32_t, ...)
* Common convention is to return 0 on success, negative number on error.
  Positive return values don't fit well into this scheme. If possible
  follow it.

Oh, and the type p80211item_uint32_t when in fact it is a 12-bytes long
structure ...

	Alexey
