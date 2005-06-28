Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbVF1KvP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbVF1KvP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 06:51:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVF1KvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 06:51:15 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:1042 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261233AbVF1KvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 06:51:13 -0400
To: "Al Boldi" <a1426z@gawab.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kswapd flaw
References: <200506280637.JAA07333@raad.intranet>
From: Nix <nix@esperi.org.uk>
X-Emacs: there's a reason it comes with a built-in psychotherapist.
Date: Tue, 28 Jun 2005 11:50:49 +0100
In-Reply-To: <200506280637.JAA07333@raad.intranet> (Al Boldi's message of
 "28 Jun 2005 07:47:44 +0100")
Message-ID: <87r7em69h2.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2005, Al Boldi murmured woefully:
> Kswapd starts evicting processes to fullfil a malloc, when it should just
> deny it because there is no swap.

This is how the kernel has always worked. If you have no swap, memory
pressure is higher than it otherwise might be, because dirty pages must
be kept in physical RAM even if they are rarely used. So when memory gets
low the kernel *has* to evict pages which aren't dirty, and write out and
flush dirty pages corresponding to files on disk.

What else could it possibly do? Stop evicting everything?

I can't even tell what you're expecting. Surely not that no pages are
ever evicted or flushed; your memory would fill up with page cache in
no time.

-- 
`I lost interest in "blade servers" when I found they didn't throw knives
 at people who weren't supposed to be in your machine room.'
    --- Anthony de Boer
