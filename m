Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264715AbSLQGdG>; Tue, 17 Dec 2002 01:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264724AbSLQGdG>; Tue, 17 Dec 2002 01:33:06 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:2052 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S264715AbSLQGdG>;
	Tue, 17 Dec 2002 01:33:06 -0500
To: linux-kernel@vger.kernel.org
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] move LOG_BUF_SIZE to header file
References: <Pine.LNX.4.33L2.0212121517300.19827-100000@dragon.pdx.osdl.net>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <Pine.LNX.4.33L2.0212121517300.19827-100000@dragon.pdx.osdl.net>
Date: 17 Dec 2002 01:39:33 -0500
Message-ID: <m3isxtm9ne.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was just looking at doing that.

I'd suggest including CONFIG_CRYPTO_TEST in the default size
determination, and allowing both smaller sizes (for low ram
applications, such as embedded systems) and larger ones.

With all of the crypto =y, the test wipes everything before ACPI out
of the buffer before syslogd gets to start and log the buffer to disk.
Even with a 64k buffer.

-JimC

