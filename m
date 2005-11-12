Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbVKLVPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbVKLVPI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 16:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbVKLVPI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 16:15:08 -0500
Received: from mail.isurf.ca ([66.154.97.68]:18621 "EHLO columbo.isurf.ca")
	by vger.kernel.org with ESMTP id S964815AbVKLVPH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 16:15:07 -0500
From: "Gabriel A. Devenyi" <ace@staticwave.ca>
To: sziwan@users.sourceforge.net
Subject: [PATCH] drivers/acpi/asus_acpi.c unsigned comparison
Date: Sat, 12 Nov 2005 16:15:02 -0500
User-Agent: KMail/1.8.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121615.02928.ace@staticwave.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

proc_write_brn, and proc_write_disp both use a parameter "count" to store the result from parse_arg.
The return of parse_arg is an int, but count is declared as an unsigned int, and later checked versus zero,
which is meaningless. This patch fixes the declaration of count in both functions.

Thanks to LinuxICC (http://linuxicc.sf.net)

Signed-off-by: Gabriel A. Devenyi <ace@staticwave.ca>



-- 
Gabriel A. Devenyi
ace@staticwave.ca
