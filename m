Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261771AbVAHCOt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbVAHCOt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 21:14:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbVAHCOt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 21:14:49 -0500
Received: from [202.108.36.218] ([202.108.36.218]:34997 "HELO netease.com")
	by vger.kernel.org with SMTP id S261771AbVAHCOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 21:14:47 -0500
X-Originating-IP: [218.82.75.131]
Subject: Wrong value in the cp936 (gb2312) codepage.
From: matt <coody@netease.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1105150357.1833.4.camel@mattwu>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 08 Jan 2005 10:14:30 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I accidentally got a wrong value in the cp936 (gb2312) codepage.

in /linux/fs/nls/nls_cp936.c:

static wchar_t c2u_B1[256] = {
...
0x5351,0xF963,0x8F88,0x80CC,0x8D1D,0x94A1,0x500D,0x72C8,/* 0xB0-0xB7 */
...
};

For 0xb1, 0xb1, the correct value should be 0x5317. You can get it at
www.microsoft.com/globaldev/reference/dbcs/936/936_B1.htm.

I didn't check all of them. But it should have possibility of containing
more wrong values. Maybe these tables need to be re-generated.


Best wishes,

Matt



