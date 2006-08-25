Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbWHYGWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbWHYGWZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 02:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWHYGWZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 02:22:25 -0400
Received: from cantor2.suse.de ([195.135.220.15]:61080 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964823AbWHYGWY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 02:22:24 -0400
From: Andi Kleen <ak@suse.de>
To: "Dong Feng" <middle.fengdong@gmail.com>
Subject: Re: Unnecessary Relocation Hiding?
Date: Fri, 25 Aug 2006 08:18:49 +0200
User-Agent: KMail/1.9.3
Cc: "Paul Mackerras" <paulus@samba.org>,
       "Christoph Lameter" <clameter@sgi.com>, linux-kernel@vger.kernel.org
References: <a2ebde260608230500o3407b108hc03debb9da6e62c@mail.gmail.com> <17646.14056.102017.127644@cargo.ozlabs.ibm.com> <a2ebde260608241830p2d26b20bp6bfb9b1b5a267ec6@mail.gmail.com>
In-Reply-To: <a2ebde260608241830p2d26b20bp6bfb9b1b5a267ec6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608250818.49139.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 25 August 2006 03:30, Dong Feng wrote:
> Sorry for perhaps extending the specific question to a more generic
> one. In which cases shall we, in current or future development,
> prevent gcc from knowing a pointer-addition in the way RELOC_HIDE? And
> in what cases shall we just write pure C point addition?
> 
> After all, we are writing an OS in C not in pure assembly, so I am
> just trying to learn some generial rules to mimize the raw assembly in
> development.

In theory anything that is undefined in the C standard should be avoided
because gcc is free to make assumptions about it and generate unexpected 
code.

In practice Linux does a lot of not-quite-legal-in-portable-C things
already, but tries to avoid areas that are known to have miscompiled in
the past.

Best is to avoid undefined behaviour in new code.

-Andi
