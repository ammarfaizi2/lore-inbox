Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbUELWdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbUELWdX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 18:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbUELWdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 18:33:23 -0400
Received: from palrel12.hp.com ([156.153.255.237]:21992 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S262129AbUELWdQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 18:33:16 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16546.42537.765495.231960@napali.hpl.hp.com>
Date: Wed, 12 May 2004 15:33:13 -0700
To: Andrew Morton <akpm@osdl.org>
Cc: davidm@hpl.hp.com, rddunlap@osdl.org, ebiederm@xmission.com,
       drepper@redhat.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [announce] kexec for linux 2.6.6
In-Reply-To: <20040512152815.76280eac.akpm@osdl.org>
References: <20040511212625.28ac33ef.rddunlap@osdl.org>
	<40A1AF53.3010407@redhat.com>
	<m13c66qicb.fsf@ebiederm.dsl.xmission.com>
	<40A243C8.401@redhat.com>
	<m1brktod3f.fsf@ebiederm.dsl.xmission.com>
	<40A2517C.4040903@redhat.com>
	<m17jvhoa6g.fsf@ebiederm.dsl.xmission.com>
	<20040512143233.0ee0405a.rddunlap@osdl.org>
	<16546.41076.572371.307153@napali.hpl.hp.com>
	<20040512152815.76280eac.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 12 May 2004 15:28:15 -0700, Andrew Morton <akpm@osdl.org> said:

  >> ia64 does have VDSO (and has had it for some time).

  >> I quite like Uli's idea.

  Andrew> Is anyone doing VDSO development for x86?  I don't recall
  Andrew> seeing anything.

It's already there?

	--david

$ tail -17 arch/i386/kernel/vsyscall.lds
/*
 * This controls what symbols we export from the DSO.
 */
VERSION
{
  LINUX_2.5 {
    global:
        __kernel_vsyscall;
        __kernel_sigreturn;
        __kernel_rt_sigreturn;

    local: *;
  };
}

/* The ELF entry point can be used to set the AT_SYSINFO value.  */
ENTRY(__kernel_vsyscall);
