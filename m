Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264898AbTGCQQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 12:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbTGCQNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 12:13:54 -0400
Received: from hera.cwi.nl ([192.16.191.8]:18160 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S265022AbTGCQLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 12:11:36 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 3 Jul 2003 18:25:59 +0200 (MEST)
Message-Id: <UTC200307031625.h63GPx209151.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] cryptoloop
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch:

> Some nitpicking:

Thanks. In case Linus applied the patch this is unimportant.
In case he didnt I'll probably resubmit when 2.5.75 comes out
and apply your polishing.

> +     if (info->lo_encrypt_type == LO_CRYPT_CRYPTOAPI)
>
> this special-casing sounds like a bad idea.

True. But it is only in the compatibility code.
Once you rip that out the special casing disappears automatically.
It describes current reality.

> imho we should rip out the whole concept of transfer functions

They are used much more frequently than cryptoapi is.
People tell me jari-loop is much faster at present.
If this is true, your move would not be very popular.

Anyway, I am not doing a redesign. Just a cleanup.

Andries
