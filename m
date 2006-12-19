Return-Path: <linux-kernel-owner+w=401wt.eu-S933035AbWLSVin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933035AbWLSVin (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933033AbWLSVin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:38:43 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33438 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932960AbWLSVim (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:38:42 -0500
Message-ID: <45885BAD.7030705@redhat.com>
Date: Tue, 19 Dec 2006 15:37:49 -0600
From: Clark Williams <williams@redhat.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux@bohmer.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG+PATCH] RT-Preempt: IRQ threads running at prio 0 SCHED_OTHER
References: <3efb10970612191252m33e7b88cydca7fb488251ee35@mail.gmail.com> <20061219212427.GA11516@elte.hu>
In-Reply-To: <20061219212427.GA11516@elte.hu>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Ingo Molnar wrote:
> 
> ok - lets try it. Clark: does this impact the set_kthread_prio utility? 
> I've changed "IRQ 123" to "IRQ-123" to make pidof & friends work better.

Yes it does, but I believe I can fix that. Most of the logic is in awk
and I believe one call to sub() will handle the change.

Clark
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFiFutHyuj/+TTEp0RAjKlAKCaVK8hf4jY6ZUIZ0Ixc56lhSUcHgCgoqT0
HiDbdVXrwY/LYlZN7AFwHOI=
=1YgX
-----END PGP SIGNATURE-----
