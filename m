Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264993AbTFCNCr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 09:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264995AbTFCNCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 09:02:47 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:36038 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S264993AbTFCNCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 09:02:46 -0400
Subject: Re: CRC32=y && 8193TOO=m unresolved symbols
From: David Woodhouse <dwmw2@infradead.org>
To: Stewart Smith <stewartsmith@mac.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <985F0B02-9560-11D7-968C-00039346F142@mac.com>
References: <985F0B02-9560-11D7-968C-00039346F142@mac.com>
Content-Type: text/plain
Organization: 
Message-Id: <1054646171.17921.64.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Tue, 03 Jun 2003 14:16:11 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-03 at 02:13, Stewart Smith wrote:
> this problem disappears when you have CONFIG_CRC32=y and 
> CONFIG_8139TOO=y. It only happens when CRC32=y and 8139TOO=m
> 
> Occurs on all 2.5.70 through bk6 (haven't tried later). Also on -mm3
> 
> I get unresolved symbols for bitreverse and crc32_le.
> 
> I've tried mucking around a bit with EXPORT_SYMBOL and the like, but I 
> have to admit, i'm stumped. Help! :)

My current solution to this, which was sent to Alan but which didn't
appear in 2.4.21-rc6-ac2, is to export the symbols from kernel/ksyms.c
#ifdef CONFIG_CRC32 and from lib/crc32.c #ifndef CONFIG_CRC32.

That should work in all circumstances.


-- 
dwmw2

