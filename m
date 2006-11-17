Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756086AbWKRAK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086AbWKRAK7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 19:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756079AbWKRAKm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 19:10:42 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:132 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1756068AbWKRAGg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 19:06:36 -0500
Date: Fri, 17 Nov 2006 17:34:32 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       akpm@osdl.org, ak@suse.de, hpa@zytor.com, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, pavel@suse.cz, rjw@sisk.pl
Subject: [RFC][PATCH 0/20] x86_64: Relocatable bzImage (V3)
Message-ID: <20061117223432.GA15449@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here is the third attempt on implementing relocatable bzImage for x86_64.

Following are the changes since V2.

- Broke suspend/resume code changes into smaller patches. Pavel, I hope
  now it is easier to review.

- Moved cpu long mode and SSE verfication code into a single common 
  file (arch/x86_64/kernel/verify_cpu.S). This file is not shared at all
  the entry places.

- Fixed a bug during resume operation on machines which support NX bit.

Your comments/suggestions are welcome.

Thanks
Vivek
