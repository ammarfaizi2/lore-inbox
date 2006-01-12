Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964919AbWALEPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964919AbWALEPU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 23:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965013AbWALEPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 23:15:20 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:52195 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964872AbWALEPS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 23:15:18 -0500
Subject: [PATCH -mm 0/10] unshare system call -v5
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: akpm@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org
Cc: chrisw@sous-sol.org, jamie@shareable.org, serue@us.ibm.com,
       sds@tycho.nsa.gov, sgrubb@redhat.com, ebiederm@xmission.com,
       janak@us.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1137038983.7488.202.camel@hobbes.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 11 Jan 2006 23:10:42 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patches represent the updated version of the proposed
new system call unshare.

Changes since -v4:
	- Added Documentation/unshare.txt file to describe the new
	  system call, why it is needed, it's cost, design, implementation
	  and test plan
	- Fixed intermittant oops encountered when starting wine applications
	- Forward ported to 2.6.15-mm3

unshare allows a process to disassociate part of the process context (vm
namespace, files and fs) that was being shared with a parent.

The latest port to 2.6.15-rc5-mm2 has been tested on a uni-processor
i386 machine.

Patches are organized as follows:

 1. Patch introduces Documentation/unshare.txt file
 2. Patch implements system call handler sys_unshare. System call
    accepts all clone(2) flags but returns -EINVAL when attempt is
    made to unshare any shared context.
 3. Patch implements unsharing of filesystem information
 4. Patch implements unsharing of namespace
 5. Patch implements unsharing of vm
 6. Patch implements unsharing of files
 7. Patch registers system call for i386 architecture
 8. Patch registers system call for powerpc architecture
 9. Patch registers system call for ppc architecture
10. Patch registers system call for x86_64 architecture


