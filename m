Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263568AbTKKPIT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 10:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263565AbTKKPIT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 10:08:19 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:3978
	"EHLO x30.random") by vger.kernel.org with ESMTP id S263568AbTKKPGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 10:06:13 -0500
Date: Tue, 11 Nov 2003 16:05:47 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Walrond <andrew@walrond.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031111150547.GG1649@x30.random>
References: <fa.eto0cvm.1v20528@ifi.uio.no> <fa.onl48uv.1tmeb21@ifi.uio.no> <3FB0EEB5.5010804@myrealbox.com> <200311111438.47868.andrew@walrond.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311111438.47868.andrew@walrond.org>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 11, 2003 at 02:38:47PM +0000, Andrew Walrond wrote:
> So you check the lock, do rsync, and check the lock again. But the lock could 
> have flipped several times during the rsync and you wouldn't know about it.
> 
> My preferred solution is a single sequence file as described by Adreas:
> 
> Assuming sequence starts at 0,
> 
> To modify the repository, +1 to sequence file contents, modify repo, +1 to 
> sequence
> 
> To get a coherent copy,
> do
> 	seq1 = read(sequence file)
> 	rsync repo
> 	seq2 = read(sequence file)
> until seq1==seq2 and !(seq1&1)

yep.
