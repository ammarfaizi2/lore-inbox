Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSLQRTk>; Tue, 17 Dec 2002 12:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265484AbSLQRTk>; Tue, 17 Dec 2002 12:19:40 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18339 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265480AbSLQRTj>;
	Tue, 17 Dec 2002 12:19:39 -0500
Date: Tue, 17 Dec 2002 09:22:28 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "James H. Cloos Jr." <cloos@jhcloos.com>
cc: <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] move LOG_BUF_SIZE to header file
In-Reply-To: <m3isxtm9ne.fsf@lugabout.jhcloos.org>
Message-ID: <Pine.LNX.4.33L2.0212170917400.17648-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Dec 2002, James H. Cloos Jr. wrote:

| I was just looking at doing that.

Did you have any ideas for a better solution?

| I'd suggest including CONFIG_CRYPTO_TEST in the default size
| determination, and allowing both smaller sizes (for low ram
| applications, such as embedded systems) and larger ones.

and I'd agree with the latter half of this, but I think that if
one <quote> Quick & dirty crypto test module </quote> causes a
log buffer overrun, the general kernel config doesn't need to provide
a solution for it.

| With all of the crypto =y, the test wipes everything before ACPI out
| of the buffer before syslogd gets to start and log the buffer to disk.
| Even with a 64k buffer.

Use a larger buffer or reduce the output?

-- 
~Randy

