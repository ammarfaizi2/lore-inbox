Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWDFOd7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWDFOd7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 10:33:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWDFOd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 10:33:59 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:38543 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932153AbWDFOd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 10:33:58 -0400
Date: Thu, 6 Apr 2006 16:31:39 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Serge Noiraud <serge.noiraud@bull.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PREEMPT_RT : 2.6.16-rt12 and boot : BUG ?
Message-ID: <20060406143139.GA28724@elte.hu>
References: <200604061416.00741.Serge.Noiraud@bull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604061416.00741.Serge.Noiraud@bull.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Serge Noiraud <serge.noiraud@bull.net> wrote:

> input: ImPS/2 Generic Wheel Mouse as /class/input/input1
> VFS: Mounted root (ext2 filesystem).
> Fusion MPT base driver 3.03.07
> Copyright (c) 1999-2005 LSI Logic Corporation
> Could not allocate 8 bytes percpu data
> mptscsih: Unknown symbol scsi_remove_host

could you increase (double) PERCPU_ENOUGH_ROOM in 
include/linux/percpu.h, does that solve this problem? (and make sure you 
use -rt13, -rt12 had a couple of bugs)

	Ingo
