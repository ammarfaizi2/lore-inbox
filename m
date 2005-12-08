Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751237AbVLHWIS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbVLHWIS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbVLHWIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:08:18 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:58821 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751237AbVLHWIS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:08:18 -0500
Subject: [PATCH -mm 0/5] New system call, unshare
From: JANAK DESAI <janak@us.ibm.com>
Reply-To: janak@us.ibm.com
To: chrisw@osdl.org, viro@ftp.linux.org.uk, dwmw2@infradead.org,
       jamie@shareable.org, serue@us.ibm.com, linuxram@us.ibm.com,
       jmorris@namei.org, sds@tycho.nsa.org, janak@us.ibm.com
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1134079693.5476.5.camel@hobbs.atlanta.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 08 Dec 2005 17:08:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The following patches represent the updated version of the proposed
new system call unshare. unshare was forward ported to the latest -mm
tree in order to apply on top of shared tree patches from Al Viro/Ram
Pai.
The updated version also incorporates feedback from Chris Wright and 
Jamie Lokier on lkml and IRC. 

unshare allows a process to disassociate part of the process context (vm
and/or namespace) that was being shared with a parent.  Unshare is
needed
to implement polyinstantiated directories (such as per-user and/or 
per-security context /tmp directory) using the kernel's per-process 
namespace mechanism. For a more detailed description of the
justification
and approach, please refer to lkml threads from 8/8/05 and 10/13/05.

Unshare system call, along with shared tree patches, have been in use
in our department for over month and half. We have been using them to
maintain per-user and per-context /tmp directory. The latest port to 
2.6.15-rc5-mm1 has been tested on a uni-processor i386 machine.

The patchset is organized as follows:

1. Patch implementing system call handler function sys_unshare
2. Patch registering system call for i386 architecture
3. Patch registering system call for powerpc architecture
4. Patch registering system call for ppc architecture
5. Patch registering system call for x86_64 architecture

If (when :-) ?) system call handler patch is accepted, I will work
with other architecture maintainers to register the new system call
for other architectures. 




