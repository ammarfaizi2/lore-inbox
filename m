Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbUBAAsa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 19:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264855AbUBAAsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 19:48:30 -0500
Received: from ozlabs.org ([203.10.76.45]:64666 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264539AbUBAAs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 19:48:29 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16412.19232.539839.794917@cargo.ozlabs.ibm.com>
Date: Sun, 1 Feb 2004 11:41:04 +1100
From: Paul Mackerras <paulus@samba.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: klibc list <klibc@zytor.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: long long on 32-bit machines
In-Reply-To: <401B464C.50004@zytor.com>
References: <4017F991.2090604@zytor.com>
	<16408.59474.427408.682002@cargo.ozlabs.ibm.com>
	<401B464C.50004@zytor.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:

> Does system calls follow the same convention?

Yes.  A system call with a long long argument will be handled by a C
routine in the kernel.  The system call arguments in r3 - r8 are
unchanged by the system call exception entry code and end up being the
arguments to the C routine.

Paul.
