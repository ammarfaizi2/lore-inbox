Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964833AbWDCFP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbWDCFP2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 01:15:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751397AbWDCFP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 01:15:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:64739 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751391AbWDCFP1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 01:15:27 -0400
Date: Sun, 2 Apr 2006 22:15:13 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@sgi.com>
Cc: sonny@burdell.org, ak@suse.com, akpm@osdl.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: Re: Fw: 2.6.16 crashes when running numastat on p575
Message-Id: <20060402221513.96f05bdc.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
References: <20060402213216.2e61b74e.akpm@osdl.org>
	<Pine.LNX.4.64.0604022149450.15895@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-		for (cpu = 0; cpu < NR_CPUS; cpu++) {
+		for_each_online_cpu(cpu) {

Idle curiosity -- what keeps a cpu from going offline during
this scan, and leaving us with the same crash as before?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
