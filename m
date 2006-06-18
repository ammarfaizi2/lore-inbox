Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751150AbWFRLUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751150AbWFRLUq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 07:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751149AbWFRLUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 07:20:46 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:40708 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751147AbWFRLUp
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 07:20:45 -0400
To: Hans Reiser <reiser@namesys.com>
Cc: Andrew Morton <akpm@osdl.org>, "Vladimir V. Saveliev" <vs@namesys.com>,
       hch@infradead.org, Reiserfs-Dev@namesys.com,
       Linux-Kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: batched write
References: <44736D3E.8090808@namesys.com> <20060524175312.GA3579@zero>
	<44749E24.40203@namesys.com> <20060608110044.GA5207@suse.de>
	<1149766000.6336.29.camel@tribesman.namesys.com>
	<20060608121006.GA8474@infradead.org>
	<1150322912.6322.129.camel@tribesman.namesys.com>
	<20060617100458.0be18073.akpm@osdl.org> <4494411B.4010706@namesys.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: don't cry -- it won't help.
Date: Sun, 18 Jun 2006 12:20:00 +0100
In-Reply-To: <4494411B.4010706@namesys.com> (Hans Reiser's message of "17 Jun 2006 18:51:46 +0100")
Message-ID: <87ac8an21r.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jun 2006, Hans Reiser prattled cheerily:
> If the FS is called per page, then it turns out that 3) costs more than
> 1) and 2) for sophisticated filesystems.  As we develop fancier and
> fancier plugins this will just get more and more true.  It decreases CPU
> usage by 2x to use per sys_write calls into reiser4 rather than per page
> calls into reiser4.

This seems to me to be something that FUSE filesystems might well like,
too: I know one I'm working on would like to know the real size of the
original write request (so that it can optimize layout appropriately
for things frequently written in large chunks; the assumption being that
if it's written in large chunks it's likely to be read in large chunks
too).

-- 
`Voting for any American political party is fundamentally
 incomprehensible.' --- Vadik
