Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262750AbTJJBex (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262755AbTJJBew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:34:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:11222 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262750AbTJJBev (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:34:51 -0400
Date: Thu, 9 Oct 2003 18:33:46 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: davidsen@tmr.com (bill davidsen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] kexec update (2.6.0-test7)
Message-Id: <20031009183346.3ae74277.rddunlap@osdl.org>
In-Reply-To: <bm4js7$6db$1@gatekeeper.tmr.com>
References: <20031008172235.70d6b794.rddunlap@osdl.org>
	<Pine.NEB.4.58.0310090401310.17767@sdf.lonestar.org>
	<m1y8vufe5l.fsf@ebiederm.dsl.xmission.com>
	<bm4js7$6db$1@gatekeeper.tmr.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9 Oct 2003 21:27:35 GMT davidsen@tmr.com (bill davidsen) wrote:

| In article <m1y8vufe5l.fsf@ebiederm.dsl.xmission.com>,
| Eric W. Biederman <ebiederm@xmission.com> wrote:
| | Cherry George Mathew <cherry@sdf.lonestar.org> writes:
| | 
| | > On Wed, 8 Oct 2003, Randy.Dunlap wrote:
| | > 
| | > > You'll need to update the kexec-syscall.c file for the correct
| | > > kexec syscall number (274).
| | > 
| | > Is there a consensus about what the syscall number will finally be ? We've
| | > jumped from 256 to 274 over the 2.5.x+  series kernels. Or is it the law
| | > the Jungle ?
| | 
| | So far the law of the jungle.  Regardless of the rest it looks like it
| | is time to submit a place keeping patch.
| 
| Forgive me if the politics of this have changed, but will a place
| keeping patch be accepted for a feature which has not? 

Like the one recently added for "vserver" ??

#define __NR_vserver            273

and

	.long sys_ni_syscall	/* sys_vserver */
(ni == not implemented)

But I don't think that it's quite time for a placeholder syscall number
(IMO of course).  Eric can submit one though.

--
~Randy
