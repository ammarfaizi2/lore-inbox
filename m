Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752481AbVHGSH5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbVHGSH5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 14:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752492AbVHGSH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 14:07:57 -0400
Received: from dvhart.com ([64.146.134.43]:57472 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S1752481AbVHGSH5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 14:07:57 -0400
Date: Sun, 07 Aug 2005 11:07:59 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: EXPORT_SYMBOL generates "is deprecated" noise
Message-ID: <251790000.1123438079@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting lots of errors like this nowadays:

drivers/serial/8250.c:2651: warning: `register_serial' is deprecated 
(declared at drivers/serial/8250.c:2607)

Which is just: "EXPORT_SYMBOL(register_serial);"

Sorry, but that's just compile-time noise, not anything useful.
Warning on real usages of it might be handy (we can go fix the users)
but not EXPORT_SYMBOL - we can't kill the export until the function
goes away. The more noise we have, the harder it is to see real errors 
and warnings.

I took a quick poke around, but can't see what generates this stuff.
What is doing these checks, and can we please make an exception for
EXPORT_SYMBOL (and EXPORT_SYMBOL_GPL) somehow?

M.

