Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbTKRNmT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbTKRNmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:42:19 -0500
Received: from ns.suse.de ([195.135.220.2]:58577 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262601AbTKRNmP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:42:15 -0500
To: Jason Baietto <jason.baietto@ccur.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64 module loader reloc problem
References: <1067455102.444.18.camel@broccoli.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 29 Oct 2003 20:36:08 +0100
In-Reply-To: <1067455102.444.18.camel@broccoli.suse.lists.linux.kernel>
Message-ID: <p73u15r96qf.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baietto <jason.baietto@ccur.com> writes:

> Note that in my linked test module, objdump shows 632 R_X86_64_32 reloc
> entries and only 18 R_X86_64_64 reloc entries.

X86_64_32 is wrong for -mcmodel=kernel. It should be X86_64_32S.
Either you didn't compile with -mcmodel=kernel or your compiler or binutils 
are buggy.

-Andi
