Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263802AbTCVRqC>; Sat, 22 Mar 2003 12:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263803AbTCVRqB>; Sat, 22 Mar 2003 12:46:01 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:13211
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263802AbTCVRqA>; Sat, 22 Mar 2003 12:46:00 -0500
Subject: Re: 2.4+ptrace exploit fix breaks root's ability to strace
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030322171312.H8712@flint.arm.linux.org.uk>
References: <20030322103121.A16994@flint.arm.linux.org.uk>
	 <1048345130.8912.9.camel@irongate.swansea.linux.org.uk>
	 <20030322141006.A8159@flint.arm.linux.org.uk>
	 <1048346885.1708.2.camel@laptop.fenrus.com>
	 <20030322171312.H8712@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048360147.9221.26.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 19:09:08 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-03-22 at 17:13, Russell King wrote:
> ptrace has always explicitly allowed a process with the CAP_SYS_PTRACE
> capability to ptrace a task which isn't dumpable.  With the ptrace "fix"
> in place, you can attach to a non-dumpable thread:

Note that this is a bug, and is now a fixed bug. The looser check you
can do requires you check

	my_capabilities >= his capbilities

Otherwise you have priviledge escalation for CAP_SYS_PTRACE to
CAP_SYS_RAWIO trivially


