Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312428AbSCZSSo>; Tue, 26 Mar 2002 13:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312643AbSCZSSf>; Tue, 26 Mar 2002 13:18:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:6967 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S312428AbSCZSSX>; Tue, 26 Mar 2002 13:18:23 -0500
Date: Tue, 26 Mar 2002 19:18:14 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Arjan van de Ven <arjanv@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, gerrit@us.ibm.com
Subject: Re: Backport of Ingo/Arjan highpte to 2.4.18 (+O1 scheduler)
Message-ID: <20020326191814.F13052@dualathlon.random>
In-Reply-To: <242250000.1016752254@flay> <20020326180841.C13052@dualathlon.random> <49720000.1017165747@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2002 at 10:02:27AM -0800, Martin J. Bligh wrote:
> 
> > First, your backport is clearly broken because it will oops in
> > copy_one_pte if the alloc_one_pte_map fails.
> 
> That doesn't suprise me ... I did a quick backport without staring
> at the code too much, just so I could get some testing number to
> see what the difference in performance would be. Arjan is doing
> a proper backport to 2.4, and he obviously knows this patch far

I need persistent kmaps for the pagetables, and also the quicklists, so
I'm not excited to integrate a 2.4 backport of an halfway solution that
isn't optimal for 2.5 either (plus at the moment it's buggy and
incidentally the right fix is to add the persistent kmaps in 2.5 too, go
figure).

Andrea
