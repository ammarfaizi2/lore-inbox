Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbTFWI0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 04:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTFWI03
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 04:26:29 -0400
Received: from hera.cwi.nl ([192.16.191.8]:19895 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264919AbTFWI02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 04:26:28 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 23 Jun 2003 10:40:32 +0200 (MEST)
Message-Id: <UTC200306230840.h5N8eWY10820.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, hch@infradead.org
Subject: Re: [PATCH] loop.c - part 1 of many
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hch:

> Once you start touching loop_{,un}register_transfer please also get
> rid of the array in favour of a linked list..

Why do you think that might be a good idea? General elegance?
The array is legacy only - it will not grow.
It has length 20, and only three entries are frequently used:
18 for CryptoAPI, 16 for loopAES, 0 for no encryption.

Andries
