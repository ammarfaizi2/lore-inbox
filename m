Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132054AbQKVB7Z>; Tue, 21 Nov 2000 20:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132125AbQKVB7Q>; Tue, 21 Nov 2000 20:59:16 -0500
Received: from lahmed.Stanford.EDU ([171.65.76.205]:52119 "EHLO
	lahmed.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S132054AbQKVB7D>; Tue, 21 Nov 2000 20:59:03 -0500
From: David Hinds <dhinds@lahmed.stanford.edu>
Date: Tue, 21 Nov 2000 17:28:17 -0800
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: Tobias Ringstrom <tori@tellus.mine.nu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why not PCMCIA built-in and yenta/i82365 as modules
Message-ID: <20001121172817.A18265@lahmed.stanford.edu>
In-Reply-To: <20001121160443.B18150@lahmed.stanford.edu> <200011220110.eAM1Ach414423@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <200011220110.eAM1Ach414423@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Tue, Nov 21, 2000 at 08:10:38PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 08:10:38PM -0500, Albert D. Cahalan wrote:
> 
> Hmmm, I'm not the only one who doesn't like modules depending
> on other modules. I suppose this is part paranoia about extra
> complexity leading to problems, and part desire to avoid the
> module overhead for common code that will most likely get used.

Since the core PCMCIA code and the socket driver are equally essential
to do anything useful with PCMCIA, the only reasonable argument I
could see for it would be if you are using one kernel on several
systems, all of which use PCMCIA, but which need different socket
drivers.  So you would save... oh... perhaps 2K by having the PCMCIA
shared code in the kernel.

In any case, I don't think it would require much more than modifying
the Config.in for the PCMCIA drivers to support this.  My own paranoia
would be that you would be adding a bunch of rarely used permutations
of config options, that would rarely be tested.

-- Dave

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
