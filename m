Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbUANVtr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264351AbUANVtr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:49:47 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:9096 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264342AbUANVtq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:49:46 -0500
Subject: Re: [PATCH] 2.6.1-mm2: Get irq_vector size right for generic
	subarch UP installer kernels
From: James Bottomley <James.Bottomley@steeleye.com>
To: jamesclv@us.ibm.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200401141201.43324.jamesclv@us.ibm.com>
References: <1074108886.11035.59.camel@mulgrave> 
	<200401141201.43324.jamesclv@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Jan 2004 16:49:41 -0500
Message-Id: <1074116982.2054.207.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-14 at 15:01, James Cleverdon wrote:
> Sorry, but we've had distro installer kernels, which are uni-proc generic 
> subarch kernels, blow up with array overflows on large systems.
> 
> What would you suggest I do instead?

For Summit just add an irq_vectors.h file that includes
mach-generic/irq-vectors.h and overrides the NR_IRQ_VECTORS value

For genericarch, I'm less certain, but it seems, given the idea behind
genericarch that it should probably be set at runtime when the arch type
becomes known

James


