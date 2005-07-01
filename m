Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263433AbVGASzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263433AbVGASzT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 14:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263408AbVGASzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 14:55:19 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:58763 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S263433AbVGASzL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 14:55:11 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: reiser4 plugins
References: <200506240241.j5O2f1eb005609@laptop11.inf.utfsm.cl>
	<200506262105.j5QL5kdR018609@turing-police.cc.vt.edu>
	<42BF2DC4.8030901@slaphack.com>
	<200506270040.j5R0eUNA030632@turing-police.cc.vt.edu>
	<42BF667C.50606@slaphack.com>
	<5284F665-873C-45B7-8DDB-5F475F2CE399@mac.com>
	<42BF7167.80201@slaphack.com>
	<EC02A684-815A-4DF8-B5C1-9029FE45E187@mac.com>
	<42C06D59.2090200@slaphack.com>
	<CD59AE36-FD15-4A4C-9E1D-AB2F8B52D653@mac.com>
	<42C08B5E.2080000@slaphack.com> <87y88vrzkg.fsf@evinrude.uhoreg.ca>
	<EBD8F590-0113-4509-9604-E6967C65C835@mac.com>
	<87mzpbrvpf.fsf@evinrude.uhoreg.ca>
	<D3A4ABBF-8062-4399-B1EC-61722295944A@mac.com>
	<87irzzrqu7.fsf@evinrude.uhoreg.ca>
	<2B1C058D-C304-4E15-ACDA-C3337E67E981@mac.com>
	<87d5q6pdyv.fsf@evinrude.uhoreg.ca>
	<C7DB345A-CD35-4A4C-89F7-5BBD3CB83DF4@mac.com>
	<874qbiey92.fsf@evinrude.uhoreg.ca> <42C50804.4050006@slaphack.com>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Fri, 01 Jul 2005 14:55:10 -0400
In-Reply-To: <42C50804.4050006@slaphack.com> (David Masover's message of "Fri,
	01 Jul 2005 04:08:20 -0500")
Message-ID: <8764vujr01.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover <ninja@slaphack.com> writes:

[snip]

> That's not to say that none of this should be userspace, just that some 
> of it most certainly *never* needs to touch userspace, such as 
> cryptocompress.

It seems that transparent encryption and compression really has little
to do file-as-directory and metafs.  There needs to be a mechanism for
specifying (per-process or per-user) keys to the kernel, but other than
that, the file or directory on which this transparent
encryption/compression has been enabled can just be accessed normally.
An attempt to access a file or directory for which a key is not
available would give EPERM (or possibly the encrypted data, but this
would be problematic for directories; it also might be the case that
only encryption of file contents and file names would be supported).

> I'm not guessing that you wanted to make it FUSE, I just want to be 
> pre-emptive here.  FUSE will NOT work well for this.

In suggesting the file-path-based search facility (which, by the way, is
an interface that does not allow for searching with terms that include
'/'), you surely cannot be suggesting that search-by-artist or IDv3 tag
support be added to the kernel.

[snip]

-- 
Jeremy Maitin-Shepard
