Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030442AbVIVQke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030442AbVIVQke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbVIVQke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:40:34 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7331 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030440AbVIVQkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:40:33 -0400
To: vgoyal@in.ibm.com
Cc: Dave Anderson <anderson@redhat.com>, Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO
 tokernel  core dumps
References: <20050921065633.GC3780@in.ibm.com>
	<m1mzm6ebqn.fsf@ebiederm.dsl.xmission.com>
	<43317980.D6AEA859@redhat.com>
	<m1d5n1cw89.fsf@ebiederm.dsl.xmission.com>
	<20050922140824.GF3753@in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 22 Sep 2005 10:38:56 -0600
In-Reply-To: <20050922140824.GF3753@in.ibm.com> (Vivek Goyal's message of
 "Thu, 22 Sep 2005 19:38:24 +0530")
Message-ID: <m1vf0tawgv.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> I quickly browsed through "crash" code and looks like it is already doing
> similiar check (kernel.c, verify_version()). It seems to be retrieving 
> "linux_banner" from core image and also retrieving banner string from vmlinux 
> and trying to match. So if banner information can be directly read from the 
> core image, probably there is no need to export it through notes. 

Sounds good.  We still need to define a note for the cpu control
registers.  Do any of the other crash dump solution capture that
information right now?

Eric

