Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbUCCX6X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 18:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbUCCX6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 18:58:23 -0500
Received: from amdext.amd.com ([139.95.251.1]:2721 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id S261292AbUCCX6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 18:58:22 -0500
Message-ID: <99F2150714F93F448942F9A9F112634C109A3935@txexmtae.amd.com>
From: paul.devriendt@amd.com
To: pavel@suse.cz, davej@redhat.com, cpufreq@www.linux.org.uk,
       linux-kernel@vger.kernel.org, davej@codemonkey.ork.uk
Subject: RE: powernow-k8-acpi driver
Date: Wed, 3 Mar 2004 17:57:35 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 6C58AF76349246-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> One more thing: is there any reason for "use-array-as-struct"?
> 
> static int query_current_values_with_pending_wait(u8 *perproc) { ...
>         perproc[PP_OFF_CVID] = hi & MSR_S_HI_CURRENT_VID;
>         perproc[PP_OFF_CFID] = lo & MSR_S_LO_CURRENT_FID; }
> 
> having 
> 
> struct cpu_power {
> 	int numps, share, cvid, cfid;
> 	char pstates[0];
> }
> 
> should do the trick...
> 							Pavel

Yes, I could get rid off the PP_OFF_crud using something like you
suggest. I'll do that while I am also doing the back port and get
them both out next week sometime.

Paul.

