Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVLVNmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVLVNmt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 08:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932323AbVLVNmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 08:42:49 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:49096
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932308AbVLVNmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 08:42:49 -0500
Message-Id: <43AABBA1.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 22 Dec 2005 14:43:45 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: <sam@ravnborg.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: .config not updated after make clean
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

since 'make clean' doesn't delete include/linux/autoconf.h (but
obviously does delete .config.cmd), .config cannot get updated anymore
if any of the Kconfig-s in the tree changes. Is there a particular
reason that include/linux/autoconf.h only gets deleted by 'make
mrproper', but not by 'make clean'? If that cannot be adjusted, I can't
see how else to force proper re-generation of .config through the
silentoldconfig target.

Thanks, Jan
