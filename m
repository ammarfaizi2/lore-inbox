Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266492AbUFUWsF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266492AbUFUWsF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:48:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266500AbUFUWsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:48:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:46535 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266492AbUFUWsA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:48:00 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SUSE Labs
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 0/2] kbuild updates
Date: Tue, 22 Jun 2004 00:50:09 +0200
User-Agent: KMail/1.6.2
Cc: Martin Schlemmer <azarah@nosferatu.za.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
References: <20040620211905.GA10189@mars.ravnborg.org> <200406210151.43325.agruen@suse.de> <20040621223108.GC2903@mars.ravnborg.org>
In-Reply-To: <20040621223108.GC2903@mars.ravnborg.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406220050.09791.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 22 June 2004 00:31, Sam Ravnborg wrote:
> But Martin has a point here.

Yes.

> Other modules uses the grep method - which will fail when the kernel
> is build with separate output and source directories.

Is there anything fundamentally wrong with invoking the test script from 
within the module makefile, when really necessary? This doesn't work very 
well if you need the test results outside of the module build.

	----- Makefile -----
	test_result := $(shell ...)
	ifneq ($(test_result),)
	EXTRA_CFLAGS := -DSOMETHING
	endif
	...
	-------- 8< --------

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG
