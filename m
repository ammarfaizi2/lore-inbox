Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTJ3Pqe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 10:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbTJ3Pqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 10:46:34 -0500
Received: from mail03.powweb.com ([63.251.216.36]:50703 "EHLO
	mail03.powweb.com") by vger.kernel.org with ESMTP id S262319AbTJ3Pqd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 10:46:33 -0500
Content-Type: text/plain
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From: "Richard Drummond" <evilrich@rcdrummond.net>
To: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James Simmons <jsimmons@infradead.org>
Date: Thu, 30 Oct 2003 15:46:33 -0000
Subject: [PATCH] Multi-head fix for tdfxfb driver
X-Mailer: PowWeb Hosting Webmail version 3.0
Message-Id: <20031030154638.28D3315D57@mail03.powweb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All

This patch (against 2.6.0-test9) corrects a bug in the tdfxfb driver with
regard to multi-head set-ups. The driver was stomping all over its default
fb_fix_screeninfo struct (the global, tdfx_fix) when initializing a card -
which could potentially causes problems when the time comes to set up the
next card. This fix makes it copy tdfx_fix first and modify only that copy.

Cheers,
Rich

