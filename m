Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263761AbUGFKg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263761AbUGFKg4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 06:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263769AbUGFKg4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 06:36:56 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:52443 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263761AbUGFKgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 06:36:55 -0400
Date: Tue, 6 Jul 2004 12:14:04 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@localhost.localdomain
To: FabF <fabian.frederick@skynet.be>
cc: linux-kernel@vger.kernel.org
Subject: Re: question about /proc/<PID>/mem in 2.4
In-Reply-To: <1089037523.2129.15.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0407061210190.20027-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jul 2004, FabF wrote:
> > Surely, the super user (i.e. CAP_SYS_PTRACE in this context) should be 
> > allowed to read any process' memory without having to do the 
> > PTRACE_ATTACH/PTRACE_PEEKUSER kind of thing which strace(8) is doing?
> 
> FYI may_ptrace_attach plugged somewhere between 2.4.21 & 22.This one get
> used as is (ie without MAY_PTRACE) in proc_pid_environ but dunno about
> reason why CAP_SYS_PTRACE isn't authoritative elsewhere.

Ok, but still nobody seems to know why the super user is not allowed to
access /proc/<PID>/mem of any task. Any code which nobody in the world
knows the reason for, is broken and should be removed.

I will wait a few weeks to see if someone does come up with the reason for
that "extra secure" check in mem_read() and if nobody has objections I'll
send Linus a patch to relax the check to a more reasonable one, namely to
allow CAP_SYS_PTRACE process to bypass any other conditions imposed.

Kind regards
Tigran

