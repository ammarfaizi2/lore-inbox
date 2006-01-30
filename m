Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030198AbWA3WiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbWA3WiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 17:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030202AbWA3WiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 17:38:21 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:42767 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030198AbWA3WiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 17:38:21 -0500
To: Emmanuel Fleury <emmanuel.fleury@labri.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ASLR] Better control on Randomization
References: <43DE710F.9020408@labri.fr>
From: Nix <nix@esperi.org.uk>
X-Emacs: if it payed rent for disk space, you'd be rich.
Date: Mon, 30 Jan 2006 22:38:10 +0000
In-Reply-To: <43DE710F.9020408@labri.fr> (Emmanuel Fleury's message of "30
 Jan 2006 20:05:19 -0000")
Message-ID: <87d5i9qr3h.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 Jan 2006, Emmanuel Fleury prattled cheerily:
> Would it be possible to tweak them independently from each other ?
> (still via procfs)

If you prelink your system, shared library randomization (of those
libraries that were prelinked) ceases: but the stack is still
randomized. If you prelink with -R, prelink uses random addresses,
which is pretty much as good as using ASLR, but faster and more
memory-efficient :)

I don't know of any specific knob, nor of a way to turn off stack
randomization but leave mmap(PROT_EXEC) randomization on.

-- 
`I won't make a secret of the fact that your statement/question
 sent a wave of shock and horror through us.' --- David Anderson
