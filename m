Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbUCXAjE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 19:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbUCXAjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 19:39:04 -0500
Received: from palrel11.hp.com ([156.153.255.246]:6295 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S262956AbUCXAjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 19:39:00 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16480.55450.730214.175997@napali.hpl.hp.com>
Date: Tue, 23 Mar 2004 16:38:50 -0800
To: Kurt Garloff <garloff@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: Non-Exec stack patches
In-Reply-To: <20040324002149.GT4677@tpkurt.garloff.de>
References: <20040323231256.GP4677@tpkurt.garloff.de>
	<20040323154937.1f0dc500.akpm@osdl.org>
	<20040324002149.GT4677@tpkurt.garloff.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 24 Mar 2004 01:21:49 +0100, Kurt Garloff <garloff@suse.de> said:

  >> Which architectures are currently making their pre-page execute
  >> permissions depend upon VM_EXEC?  Would additional arch patches
  >> be needed for this?

  Kurt> It works on AMD64 (not ia32e), both for 64bit and 32bit
  Kurt> binaries.  I have not yet tested other archs.

IA64 Linux had non-executable stack/data before PT_GNU_STACK was invented.
It's keyed off a ELF header flags bit:

/* Least-significant four bits of ELF header's e_flags are
   OS-specific.  The bits are interpreted as follows by Linux: */
#define EF_IA_64_LINUX_EXECUTABLE_STACK 0x1

I guess I never quiet understood why an entire program header is
needed for this, but that's just me.

	--david
