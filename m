Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966246AbWKNS6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966246AbWKNS6W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 13:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933478AbWKNS6W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 13:58:22 -0500
Received: from ns2.suse.de ([195.135.220.15]:13234 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S933477AbWKNS6V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 13:58:21 -0500
From: Andi Kleen <ak@suse.de>
To: "Aaron Durbin" <adurbin@google.com>
Subject: Re: [PATCH for 2.6.19] [6/9] x86_64: Update MMCONFIG resource insertion to check against e820 map.
Date: Tue, 14 Nov 2006 19:58:00 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, "Matthew Wilcox" <matthew@wil.cx>
References: <20061114508.445749000@suse.de> <p73irhhdgau.fsf@bingen.suse.de> <8f95bb250611141047k2f879893g7ea42768247e576@mail.gmail.com>
In-Reply-To: <8f95bb250611141047k2f879893g7ea42768247e576@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611141958.00289.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I would like to know what others think regarding this area. I think it
> would be a good
> idea to converge the mmconfig.c implementations for both x86-64 and i386. Is
> this not feasable for some reasons I am unaware of?  It should lead to more
> code reuse and allow for a more unified stance in how both architectures handle
> the PCI memory-mapped config space.

Yes, it should be done. But not 100% because x86-64 can use a much more
efficient mapping scheme than i386.

Probably with a mmconfig-common.c. When mmconfig.c was originally written
there wasn't that much support code and the fork wasn't a issue, it just has 
grown over time as we work around more and more bugs.

-Andi
