Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263251AbTIAT73 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 15:59:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263258AbTIAT73
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 15:59:29 -0400
Received: from dsl-hkigw4a35.dial.inet.fi ([80.222.48.53]:60873 "EHLO
	dsl-hkigw4a35.dial.inet.fi") by vger.kernel.org with ESMTP
	id S263251AbTIAT70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 15:59:26 -0400
Date: Mon, 1 Sep 2003 22:59:21 +0300 (EEST)
From: Petri Koistinen <petri.koistinen@iki.fi>
X-X-Sender: petri@dsl-hkigw4a35.dial.inet.fi
To: linux-kernel@vger.kernel.org
Subject: Sparse warning: bitmap.h: bad constant expression
Message-ID: <Pine.LNX.4.56.0309012249230.14789@dsl-hkigw4a35.dial.inet.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

If I try to compile latest kernel with "make C=1" I'll get many warning
messages from sparse saying:

warning: include/linux/bitmap.h:85:2: bad constant expression
warning: include/linux/bitmap.h:98:2: bad constant expression

Sparse doesn't seem to like DECLARE_BITMAP macros.

#define DECLARE_BITMAP(name,bits) \
        unsigned long name[BITS_TO_LONGS(bits)]

So what is wrong with this and how it could be fixed so that sparse
wouldn't complain?

Best regards,
Petri Koistinen
