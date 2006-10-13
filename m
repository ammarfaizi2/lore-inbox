Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751437AbWJMRfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbWJMRfL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 13:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751401AbWJMRfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 13:35:11 -0400
Received: from outbound0.mx.meer.net ([209.157.153.23]:63236 "EHLO
	outbound0.sv.meer.net") by vger.kernel.org with ESMTP
	id S1751437AbWJMRfJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 13:35:09 -0400
Subject: Re: [patch 6/7] process filtering for fault-injection capabilities
From: Don Mullis <dwm@meer.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, akpm@osdl.org
In-Reply-To: <452df238.04819267.55ff.ffffd8a2@mx.google.com>
References: <20061012074305.047696736@gmail.com> >
	  <452df238.04819267.55ff.ffffd8a2@mx.google.com>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 10:28:54 -0700
Message-Id: <1160760534.31851.58.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-10-12 at 16:43 +0900, Akinobu Mita wrote:
> This patch provides process filtering feature.
> The process filter allows failing only permitted processes
> by /proc/<pid>/make-it-fail

Akinobu: Toward the end of the previous round of review, we had 
the following exchange:
        
        On Tue, 2006-09-19 at 17:05 +0800, Akinobu Mita wrote:
        On Mon, Sep 18, 2006 at 10:54:51PM -0700, Don Mullis wrote:
        > > Add functionality to the process_filter variable: A negative argument
        > > injects failures for only for pid==-process_filter, thereby permitting
        > > per-process failures from boot time.
        > > 
        > 
        > Is it better to add new filter for this purpose?
        > Because someone may want to filter by tgid instead of pid.
        > 
        > - positive value is for task->pid
        > - nevative value is for task->tgid
        
        Your idea sounds good to me.


So naturally I'm wondering why the functionality was dropped.
An application I had in mind was to identify which of the boot-time
calls to the slab allocator must not fail but are not yet marked
__GFP_NOFAIL (some experimentation showed that for pid 1 there are
lots of these).

Andrew: Would such an exercise would be worth the effort?





