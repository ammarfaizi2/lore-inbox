Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263922AbUDPWTG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 18:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263905AbUDPWRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 18:17:38 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:1697 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263903AbUDPWOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 18:14:09 -0400
Date: Fri, 16 Apr 2004 23:13:10 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, mingo@redhat.com,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: fix __exit_mm() dereference before check.
Message-ID: <20040416221310.GX20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	mingo@redhat.com, Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040416210828.GK20937@redhat.com> <Pine.LNX.4.58.0404161458510.3947@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0404161458510.3947@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 03:01:32PM -0700, Linus Torvalds wrote:

 > The mm->mm_users check is protected by "tsk->clear_child_tid", and that 
 > will have been cleared already if we ever happen to call __exit_mm() 
 > twice, so that one is safe.

Yes, I missed this.

 > So this patch might be a cleanup, but not a "fix" per se.

ACK.

		Dave

