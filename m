Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265990AbTFWI37 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 04:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265991AbTFWI37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 04:29:59 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:49167 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265990AbTFWI36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 04:29:58 -0400
Date: Mon, 23 Jun 2003 09:44:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Andries.Brouwer@cwi.nl
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] loop.c - part 1 of many
Message-ID: <20030623094404.A3427@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	torvalds@transmeta.com
References: <UTC200306230840.h5N8eWY10820.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200306230840.h5N8eWY10820.aeb@smtp.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Jun 23, 2003 at 10:40:32AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 23, 2003 at 10:40:32AM +0200, Andries.Brouwer@cwi.nl wrote:
> Why do you think that might be a good idea? General elegance?
> The array is legacy only - it will not grow.
> It has length 20, and only three entries are frequently used:
> 18 for CryptoAPI, 16 for loopAES, 0 for no encryption.

Having fixed arrays for extenions is generally a bad design, yes.
Also selection of those extensions by magic number is very very bad,
IMHO we should replace it with a by-name selection before any other
transformation is added to the kernel so we can just special-case the
existing two onesand stop worrying about magic numbers.

