Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268664AbUILLNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268664AbUILLNW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:13:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUILLNW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:13:22 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:26331 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S268664AbUILLNT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:13:19 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] Yielding processor resources during lock contention
Date: Sun, 12 Sep 2004 13:12:17 +0200
User-Agent: KMail/1.6.2
Cc: Zwane Mwaikambo <zwane@fsmlabs.com>, Linus Torvalds <torvalds@osdl.org>,
       Paul Mackerras <paulus@samba.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Eberhard Pasch <epasch@de.ibm.com>
References: <Pine.LNX.4.58.0409021231570.4481@montezuma.fsmlabs.com> <200409121210.32259.arnd@arndb.de> <20040912104306.GA25741@krispykreme>
In-Reply-To: <20040912104306.GA25741@krispykreme>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_V8CRB6ClQZpeqR1";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409121312.21358.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_V8CRB6ClQZpeqR1
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Sonntag, 12. September 2004 12:43, Anton Blanchard wrote:
> cpu_relax doesnt tell us why we are busy looping. In this particular
> case we want to pass to the hypervisor which virtual cpu we are waiting
> on so the hypervisor make better scheduling decisions.

Ah, interesting. I think s390 could do the same with the upcoming 5.1 release
of z/VM. However, we decided to ask for an implementation of a futex hypercall
instead, which lets us implement the linux spinlock as a hypervisor semaphore.

> Did you manage to see any improvement by yielding to the hypervisor
> in cpu_relax?
I'm not sure if this has been measured, maybe Martin or Eberhard knows more.

	Arnd <><

--Boundary-02=_V8CRB6ClQZpeqR1
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBRC8U5t5GS2LDRf4RAtFOAJ9LxZiwPuovwKKeYhrsQN0FnbiOgACfX9Nh
2UNduPRAMB4hmVnYKRKgJ6E=
=rjLq
-----END PGP SIGNATURE-----

--Boundary-02=_V8CRB6ClQZpeqR1--
