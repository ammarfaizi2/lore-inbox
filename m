Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbWJCKL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbWJCKL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964865AbWJCKL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:11:59 -0400
Received: from mail.suse.de ([195.135.220.2]:60341 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964864AbWJCKL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:11:59 -0400
From: Andi Kleen <ak@suse.de>
To: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH/RFC] Math-emu kills the kernel on Athlon64 X2 II -- it's terminally broken
Date: Tue, 3 Oct 2006 12:11:46 +0200
User-Agent: KMail/1.9.3
Cc: Linus Torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>,
       Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <9a8748490609181518j2d12e4f0l2c55e755e40d38c2@mail.gmail.com> <Pine.LNX.4.64.0610021932080.3952@g5.osdl.org> <20061002202426.aa3ecb4f.rdunlap@xenotime.net>
In-Reply-To: <20061002202426.aa3ecb4f.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610031211.46168.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 October 2006 05:24, Randy Dunlap wrote:

Actually I looked at the code more closely. It looks like kernel math
emulation is much more broken. e.g. kernel_fpu_begin() is missing
code and lots of other paths in i387 that need to check HAVE_HWFP don't.

Fixing it properly would be much more work.

Since it evidently hasn't worked for a long time I'm thinkin about
just marking it CONFIG_BROKEN and deprecating it for 2.6.20

Comments? 

-Andi

