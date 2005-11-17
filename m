Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbVKQWBX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbVKQWBX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 17:01:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbVKQWBX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 17:01:23 -0500
Received: from smtp.osdl.org ([65.172.181.4]:58048 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932114AbVKQWBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 17:01:22 -0500
Date: Thu, 17 Nov 2005 14:01:38 -0800
From: Andrew Morton <akpm@osdl.org>
To: vgoyal@in.ibm.com
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org, ak@suse.de,
       ebiederm@xmission.com
Subject: Re: [PATCH 2/10] kdump: dynamic per cpu allocation of memory for
 saving cpu registers
Message-Id: <20051117140138.454c59a8.akpm@osdl.org>
In-Reply-To: <20051117132004.GF3981@in.ibm.com>
References: <20051117131339.GD3981@in.ibm.com>
	<20051117131825.GE3981@in.ibm.com>
	<20051117132004.GF3981@in.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please always generate diffs against the latest kernel!  I changed the
patch to reflect the new location of ppc64's machine_kexec.c.

In that file, I notice that this comment has become more informative:

/*
 * Provide a dummy crash_notes definition until crash dump is implemented.
 * This prevents breakage of crash_notes attribute in kernel/ksysfs.c.
 */
note_buf_t crash_notes[NR_CPUS];

Please check that with your new implementation, the above "breakage"
(whatever it was) remains fixed.

