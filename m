Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLOTtF>; Fri, 15 Dec 2000 14:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLOTs4>; Fri, 15 Dec 2000 14:48:56 -0500
Received: from runyon.cygnus.com ([205.180.230.5]:36862 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S129183AbQLOTsq>;
	Fri, 15 Dec 2000 14:48:46 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: "linux-kernel@vger.kernel.or" <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.18 signal.h
In-Reply-To: <Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com>
	<20001215175632.A17781@inspiron.random>
	<Pine.LNX.3.95.1001215120537.1093A-100000@chaos.analogic.com>
	<20001215184325.B17781@inspiron.random>
	<4.3.2.7.2.20001215185622.025f8740@mail.lauterbach.com>
	<20001215195433.G17781@inspiron.random>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
From: Ulrich Drepper <drepper@redhat.com>
Date: 15 Dec 2000 11:18:35 -0800
In-Reply-To: Andrea Arcangeli's message of "Fri, 15 Dec 2000 19:54:33 +0100"
Message-ID: <m3hf45ze5w.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> x()
> {
> 
> 	switch (1) {
> 	case 0:
> 	case 1:
> 	case 2:
> 	case 3:
> 	;
> 	}
> }
> 
> Why am I required to put a `;' only in the last case and not in all
> the previous ones? Or maybe gcc-latest is forgetting to complain about
> the previous ones ;)

Your C language knowledge seems to have holes.  It must be possible to
have more than one label for a statement.  Look through the kernel
sources, there are definitely cases where this is needed.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
