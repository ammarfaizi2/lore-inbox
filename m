Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264632AbTFYQRt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 12:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264634AbTFYQRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 12:17:49 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:57350 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264632AbTFYQRt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 12:17:49 -0400
Date: Wed, 25 Jun 2003 17:31:56 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: timer question?
Message-ID: <Pine.LNX.4.44.0306251722470.26713-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Currently the framebuffer console initializes one timer to flash the 
cursor. In the timer function we call schedule_work. I like to support 
more than one cursor, one for each framebuffer. Now the question is which 
is better to do?

1) To use one timer and go threw all the framebuffer devices pushing data 
   threw schedule_work for each one.

2) Create a seperate timer for each framebuffer.

