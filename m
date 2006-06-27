Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161298AbWF0UmG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161298AbWF0UmG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 16:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161299AbWF0UmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 16:42:06 -0400
Received: from unn-206.superhosting.cz ([82.208.4.206]:50566 "EHLO
	mail.aiken.cz") by vger.kernel.org with ESMTP id S1161298AbWF0UmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 16:42:04 -0400
Message-ID: <44A1982C.1010008@kernel-api.org>
Date: Tue, 27 Jun 2006 22:42:20 +0200
From: Lukas Jelinek <info@kernel-api.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; cs-CZ; rv:1.7.12) Gecko/20050915
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel API Reference Documentation
References: <44A1858B.9080102@kernel-api.org> <20060627132226.2401598e.rdunlap@xenotime.net>
In-Reply-To: <20060627132226.2401598e.rdunlap@xenotime.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
> FYI, there are already some kernel-doc rules in
> Documentation/kernel-doc-nano-HOWTO.txt.  These rules work with the
> doc. generator in the kernel tree (scripts/kernel-doc).
> Do you have suggestions for how to make them (the rules) better?
> so that the in-tree kernel doc. will improve...

These rules seem to be good. I will try to use the generator
(scripts/kernel-doc) and check the result.

But the bigger problem is that many headers are not documented at all.
And some code is documented but not complying the rules.

> 
> Q2:  what do I get when I download one of the tarballs from kernel-api.org?
> 

Each tarball contains exactly the same as can be browsed online at
kernel-api.org. There is no difference.


> Q3:  Can we see your sed scripts?
> 

Yes, here it is (it's really small and mindless):

--- sed script begin ---

/^\(\s\)*#endif/ {
s/\/\*/\/\//
s/\*\///
}

/^\(\s\)*\/\*.*\*\/\(\s\)*$/ {
s/\/\*/\/\/\//
s/\*\///
}

/^.*\/\*.*\*\/\(\s\)*$/ {
s/\/\*/\/\/\/</
s/\*\///
}

s/^\(\s\)*\/\*/\/\*\*\n/

s/^.*\*\//\n\*\//

--- sed script end ---

