Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264488AbUANTiB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:38:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264471AbUANTgg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:36:36 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:13442 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264323AbUANTfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:35:22 -0500
Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic
	subarch UP installer kernels
From: James Bottomley <James.Bottomley@steeleye.com>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Jan 2004 14:34:45 -0500
Message-Id: <1074108886.11035.59.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't think this:

+# if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)

Is a good idea.  You're contaminating the default subarch with another
subarch specific #define.

generic arch additions are fine here, but you should find a better way
to abstract the summit stuff.

James


