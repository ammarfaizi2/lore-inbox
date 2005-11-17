Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbVKQNNo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbVKQNNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 08:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbVKQNNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 08:13:44 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:44441 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750803AbVKQNNn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 08:13:43 -0500
Date: Thu, 17 Nov 2005 18:43:39 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>
Cc: ak@suse.de, "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 0/10] Kdump Update i386/x86_64
Message-ID: <20051117131339.GD3981@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Following set of patches is an update to kdump on i386 and x86_64. Changes
arises mainly due to review comments received during last posting of
kdump for x86_64.

Vivek Goyal:
	- i386 save ss esp bug fix
	- dynamic per cpu allocation of memory for saving cpu registers
	- export per cpu crash notes pointer through sysfs
	- save registers early (inline functions)

Murali M:
	- x86_64 add memmmap command line option
	- x86_64 add elfcorehdr command line option
	- x86_64 kexec on panic
	- x86_64 save cpu registers upon crash

Rachita Kothiyal:
	- read previous kernel's memory
	- kexec increase max segment limit

This set of patches has been tested on i386 and em64t x86_64 machine. Crash
dumps can be captured and opened using gdb and crash-4.0-2.12.

Corresponding kexec-tools patches are being posted in a separate set
on fastboot mailing list.

Thanks
Vivek
