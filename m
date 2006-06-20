Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWFTU5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWFTU5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 16:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751061AbWFTU5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 16:57:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:30423 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751060AbWFTU5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 16:57:42 -0400
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [RFC, patch] i386: vgetcpu()
Date: Tue, 20 Jun 2006 22:57:16 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <200606201628_MC3-1-C2FA-3586@compuserve.com>
In-Reply-To: <200606201628_MC3-1-C2FA-3586@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606202257.16033.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 June 2006 22:25, Chuck Ebbert wrote:
> Use the limit field of a GDT entry to store the current CPU
> number for fast userspace access.  This still leaves 12 bits
> free for other information.

Nice trick. Maybe I'll even add that to the x86-64 implementation
if it's fast enough. Do you have numbers?

But it needs to be encapsulated in a wrapper I think. Just exposing
it to user space is the wrong way to do this.

-Andi
