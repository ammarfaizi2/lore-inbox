Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290592AbSBFPEQ>; Wed, 6 Feb 2002 10:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290595AbSBFPEG>; Wed, 6 Feb 2002 10:04:06 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:62213 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S290592AbSBFPEA>; Wed, 6 Feb 2002 10:04:00 -0500
Message-Id: <200202061402.g16E2Nt32223@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Andi Kleen <ak@suse.de>
Subject: Re: kernel: ldt allocation failed
Date: Wed, 6 Feb 2002 16:02:25 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0112070057480.20196-100000@tombigbee.pixar.com.suse.lists.linux.kernel> <200202061258.g16CwGt31197@Port.imtp.ilyichevsk.odessa.ua.suse.lists.linux.kernel> <p73ofj2lpdg.fsf@oldwotan.suse.de>
In-Reply-To: <p73ofj2lpdg.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 February 2002 11:19, Andi Kleen wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> > I am ignorant on the subject, but why LDT is used in Linux at all?
> > LDT register can be set to 0, this can speed up task switch time and save
> > some memory used for LDT.
>
> glibc thread local data uses an LDT for the segment register.
>
> glibc 2.3 seems to plan to use segment register based thread local data for
> even non threaded programs, so it would be a good idea to optimize LDT
> allocation a bit (= not allocate 64K of vmalloc space every time
> sys_modify_ldt is called - there is only 8MB of it)

What do they use on arches without LDT or equivalent?
--
vda
