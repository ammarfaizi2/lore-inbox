Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268979AbUIXRw0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268979AbUIXRw0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 13:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268971AbUIXRw0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 13:52:26 -0400
Received: from rproxy.gmail.com ([64.233.170.207]:50058 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268980AbUIXRt6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 13:49:58 -0400
Message-ID: <4ef5fec604092410491fbae33b@mail.gmail.com>
Date: Fri, 24 Sep 2004 10:49:29 -0700
From: Martin Peck <coderman@gmail.com>
Reply-To: Martin Peck <coderman@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Longhaul cpu frequency scaling leads to segmentation violation in userspace
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have encountered a strange scenario using 2.6.8.1 on a VIA C5P
mini-itx system when Longhaul CPU frequency scaling is enabled.

When filling a buffer with entropy via xstore in kernel space a tight
loop can be performed without any problems.

If the xstore is invoked in the same iterative manner in user space
for a sufficient number of iterations (~ 120 or more) the application
is terminated due to a segmentation violation.

Adding a short delay between iterations or turning off CPU frequency
scaling resolves the problem.

Is there something associated with CPU frequency scaling and processor
intensive operations in user space that leads to unexpected timeslice
overrun (or any other side effect) causing a segmentation violation?

This behavior is very strange; any insight would be appreciated.

Regards,
