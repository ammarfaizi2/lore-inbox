Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263325AbTJKQuZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Oct 2003 12:50:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263327AbTJKQuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Oct 2003 12:50:25 -0400
Received: from fw.osdl.org ([65.172.181.6]:36270 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263325AbTJKQuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Oct 2003 12:50:19 -0400
Date: Sat, 11 Oct 2003 09:49:10 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Bill Davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] kexec update (2.6.0-test7)
Message-Id: <20031011094910.1283d784.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.3.96.1031011095434.17208B-100000@gatekeeper.tmr.com>
References: <20031009183346.3ae74277.rddunlap@osdl.org>
	<Pine.LNX.3.96.1031011095434.17208B-100000@gatekeeper.tmr.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Oct 2003 09:57:15 -0400 (EDT) Bill Davidsen <davidsen@tmr.com> wrote:

| On Thu, 9 Oct 2003, Randy.Dunlap wrote:
| 
| > On 9 Oct 2003 21:27:35 GMT davidsen@tmr.com (bill davidsen) wrote:
| > 
| > | In article <m1y8vufe5l.fsf@ebiederm.dsl.xmission.com>,
| > | Eric W. Biederman <ebiederm@xmission.com> wrote:
| > | | Cherry George Mathew <cherry@sdf.lonestar.org> writes:
| > | | 
| > | | > On Wed, 8 Oct 2003, Randy.Dunlap wrote:
| > | | > 
| > | | > > You'll need to update the kexec-syscall.c file for the correct
| > | | > > kexec syscall number (274).
| > | | > 
| > | | > Is there a consensus about what the syscall number will finally be ? We've
| > | | > jumped from 256 to 274 over the 2.5.x+  series kernels. Or is it the law
| > | | > the Jungle ?
| > | | 
| > | | So far the law of the jungle.  Regardless of the rest it looks like it
| > | | is time to submit a place keeping patch.
| > | 
| > | Forgive me if the politics of this have changed, but will a place
| > | keeping patch be accepted for a feature which has not? 
| > 
| > Like the one recently added for "vserver" ??
| > 
| > #define __NR_vserver            273
| > 
| > and
| > 
| > 	.long sys_ni_syscall	/* sys_vserver */
| > (ni == not implemented)
| > 
| > But I don't think that it's quite time for a placeholder syscall number
| > (IMO of course).  Eric can submit one though.
| 
| No, I wasn't clear. The question was if (a) Linus is still opposed to the
| implementation, and (b) if any new feature will make it into 2.6, given
| the "only fix bugs" edict recently.

I don't know the answer to (a).  I don't even recall what caused it
to be dropped from -mm a few months ago, but I should look that up,
or if anyone recalls, please refresh my memory.

Unless 2.6 is much different from past kernel versions, new features
can be added after 2.6.0-final is out, usually if they are well-contained,
like a new driver or filesystem.  I don't see this as a big hurdle.

--
~Randy
