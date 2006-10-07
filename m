Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932827AbWJGUbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbWJGUbJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Oct 2006 16:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932828AbWJGUbJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Oct 2006 16:31:09 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51077 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932827AbWJGUbD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Oct 2006 16:31:03 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Gabor Gombas <gombasg@sztaki.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, caszonyi@rdslink.ro,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Merge window closed: v2.6.19-rc1
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<Pine.LNX.4.62.0610062041440.1966@grinch.ro>
	<Pine.LNX.4.64.0610061110050.3952@g5.osdl.org>
	<m1irixz2mt.fsf@ebiederm.dsl.xmission.com>
	<20061007182325.GA9185@boogie.lpds.sztaki.hu>
Date: Sat, 07 Oct 2006 14:29:35 -0600
In-Reply-To: <20061007182325.GA9185@boogie.lpds.sztaki.hu> (Gabor Gombas's
	message of "Sat, 7 Oct 2006 20:23:25 +0200")
Message-ID: <m1mz87x428.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gabor Gombas <gombasg@sztaki.hu> writes:

> On Fri, Oct 06, 2006 at 01:05:14PM -0600, Eric W. Biederman wrote:
>
>> That code if it gets -ENOSYS reads /proc/sys/kernel/version,
>> and it has worked this way since the day it was written.
>
> What happens if /proc is not mounted (e.g. in a chrooted environment)?

glibc decides we aren't a SMP system so it's mutex locks don't
busy wait, and go to sleep immediately.

Eric
