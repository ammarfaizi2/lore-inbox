Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751279AbVHLUwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbVHLUwb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 16:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVHLUwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 16:52:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:21973 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932080AbVHLUwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 16:52:30 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [patch 0/39] remap_file_pages protection support, try 2
References: <200508122033.06385.blaisorblade@yahoo.it.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 12 Aug 2005 22:52:28 +0200
In-Reply-To: <200508122033.06385.blaisorblade@yahoo.it.suse.lists.linux.kernel>
Message-ID: <p733bpe3mk3.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade <blaisorblade@yahoo.it> writes:

> Ok, I've been working for the past two weeks learning well the Linux VM, 
> understanding the Ingo's remap_file_pages protection support and its various 
> weakness (due to lack of time on his part), and splitting and finishing it.

I'm not sure remap_file_pages was ever intended to be more integrated.
It pretty much always was a Oracle specific performance hack. The problem
with making it more powerful is that it will become more invasive then
(like your patchbomb shows) and that will make it a bigger maintenance
issue longer term and complicate all of VM. And it's probably not
worth doing all that.

So in short I think it's better to keep it into its corner with minimum
functionality and let it not expand to other parts.

-Andi
