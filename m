Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbUKDVO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbUKDVO1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUKDVKp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:10:45 -0500
Received: from ozlabs.org ([203.10.76.45]:18069 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262413AbUKDVEn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:04:43 -0500
Date: Fri, 5 Nov 2004 08:04:25 +1100
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: nickpiggin@yahoo.com.au, pj@sgi.com, colpatch@us.ibm.com
Subject: cache_hot_time
Message-ID: <20041104210425.GC1268@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Im catching up on all the scheduler changes, and I noticed some large
changes in cache_hot_time. All but ia64 seem to have shifted by 1000. Is
this intententional?

Anton

include/linux/topology.h:       .cache_hot_time         = (5*1000/2),       
include/asm-i386/topology.h:    .cache_hot_time         = (10*1000),
include/asm-ppc64/topology.h:   .cache_hot_time         = (10*1000),
include/asm-x86_64/topology.h:  .cache_hot_time         = (10*1000),
include/asm-ia64/topology.h:    .cache_hot_time         = (10*1000000),
include/asm-ia64/topology.h:    .cache_hot_time         = (10*1000000),
