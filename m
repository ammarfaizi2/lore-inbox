Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbTDKVCM (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 17:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbTDKVCM (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 17:02:12 -0400
Received: from hera.cwi.nl ([192.16.191.8]:22955 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261829AbTDKVCL (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 17:02:11 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 11 Apr 2003 23:13:52 +0200 (MEST)
Message-Id: <UTC200304112113.h3BLDq723847.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, James.Bottomley@steeleye.com
Subject: Re: [patch for playing] Patch to support 4000 disks and maintain backward compatibility
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       pbadari@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It would also be nice for numeric compatibility to be a compile time option

It sounds as if you expect a lot of old cruft.
But the compatibility code is just ten lines or so.
Internally the kernel has an index. Externally there is a dev_t.
At open() time the dev_t is converted. At registration time
sd announces interest in three or four dev_t regions.
That is all.

Andries
