Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264519AbUEXVzR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264519AbUEXVzR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264577AbUEXVzR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:55:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:41124 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264519AbUEXVzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:55:14 -0400
Date: Mon, 24 May 2004 14:57:52 -0700
From: Andrew Morton <akpm@osdl.org>
To: Gerd Knorr <kraxel@bytesex.org>, linux-kernel@vger.kernel.org
Subject: drivers/media/video/ir-kbd-gpio.c compile error
Message-Id: <20040524145752.66376880.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ir_codes_avermedia[] is trying to initialise the 24'th element to
two different values:

static IR_KEYTAB_TYPE ir_codes_avermedia[IR_KEYTAB_SIZE] = {

	...
	[ 24 ] = KEY_EJECTCD,     // Unmarked on my controller
	...
	[ 24 ] = KEY_RED,         // unmarked

Does anyone know which one is correct?
