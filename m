Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTEaOIP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 10:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTEaOIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 10:08:14 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:6666 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264330AbTEaOIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 10:08:13 -0400
Date: Sat, 31 May 2003 15:21:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Heath <chris@heathens.co.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5] UTF-8 support in console
Message-ID: <20030531152133.A32144@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Heath <chris@heathens.co.nz>, linux-kernel@vger.kernel.org
References: <20030531095521.5576.CHRIS@heathens.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030531095521.5576.CHRIS@heathens.co.nz>; from chris@heathens.co.nz on Sat, May 31, 2003 at 10:10:54AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


+static void set_inverse_trans_unicode(struct vc_data *conp, struct uni_pagedir *p)

Please linewrap after 80 chars.

+{
+	int i, j, k, glyph;
+	u16 **p1, *p2;
+	u16 *q;
+	
+	if (!p) return;

Please split this into two lines. Can p ever be null_

+	q = p->inverse_trans_unicode;
+
+	if (!q) {

Kill the blank line above.

+		q = p->inverse_trans_unicode = (u16 *) 
+			kmalloc(MAX_GLYPH * sizeof(u16), GFP_KERNEL);

The cast is not needed.  And btw, where is q freed?

+		if (!q) return;

Two lines again.

