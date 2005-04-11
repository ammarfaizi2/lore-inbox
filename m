Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVDKTij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVDKTij (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 15:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261897AbVDKTij
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 15:38:39 -0400
Received: from mx1.suse.de ([195.135.220.2]:33164 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261895AbVDKTih (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 15:38:37 -0400
From: Chris Mason <mason@suse.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: New SCM and commit list
Date: Mon, 11 Apr 2005 15:32:49 -0400
User-Agent: KMail/1.8
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@steeleye.com>,
       David Woodhouse <dwmw2@infradead.org>
References: <1113174621.9517.509.camel@gaston> <20050411073844.GA5485@elte.hu> <200504110851.14416.mason@suse.com>
In-Reply-To: <200504110851.14416.mason@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504111532.50330.mason@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 11 April 2005 08:51, Chris Mason wrote:

> rej -M skips the merge program, so rej -a -M will give you something like
> this:
>
> coffee:/local/linux.p # rej -a -M drivers/ide/ide.c.rej
>         drivers/ide/ide.c: 1 matched, 0 conflicts remain
>
> But I would want to go over the bit that calculates the conflicts remaining
> more carefully if people plan on trusting this ;) 

Ok,  looks like this should be safe.  I changed -q to skip the gui compare 
when rej thinks it has resolved all the conflicts correctly.  With rej 0.14 
(just uploaded now) this should do what you want:

rej -q -a foo.rej 

Download site is here: ftp://ftp.suse.com/pub/people/mason/rej/

Please let me know if you find patches where rej is doing the wrong thing.

-chris
