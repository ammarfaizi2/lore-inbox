Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbUB0Dgh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 22:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbUB0Dgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 22:36:37 -0500
Received: from thunk.org ([140.239.227.29]:52385 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261438AbUB0Dgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 22:36:36 -0500
Date: Thu, 26 Feb 2004 22:36:30 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       drepper@redhat.com
Subject: Re: [PATCH] Add getdents32t syscall
Message-ID: <20040227033630.GB8645@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jakub Jelinek <jakub@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
	drepper@redhat.com
References: <20040226193819.GA3501@sunsite.ms.mff.cuni.cz> <Pine.LNX.4.58.0402261411420.7830@ppc970.osdl.org> <Pine.LNX.4.58.0402261415590.7830@ppc970.osdl.org> <20040226223212.GA31589@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040226223212.GA31589@devserv.devel.redhat.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 26, 2004 at 05:32:26PM -0500, Jakub Jelinek wrote:
> (since 1997 or so), so with the extended getdents syscall glibc would need
> to memmove every name by 1 byte.

Glibc will have to have the code to play the memmove game for
compatibility with existing kernels.  So the question is whether or
not the memmove by one byte will actually be noticeable for most
application.  Has anyone checked to see whether or not it would even
be noticeable on a profiling run?

						- Ted
