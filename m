Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317605AbSGFEeB>; Sat, 6 Jul 2002 00:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317606AbSGFEeA>; Sat, 6 Jul 2002 00:34:00 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:5906 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S317605AbSGFEd7>; Sat, 6 Jul 2002 00:33:59 -0400
Date: Sat, 6 Jul 2002 00:31:09 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Rob Landley <landley@trommello.org>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [OKS] O(1) scheduler in 2.4
In-Reply-To: <20020705204513.3FF49C57@merlin.webofficenow.com>
Message-ID: <Pine.LNX.3.96.1020706002520.12368C-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jul 2002, Rob Landley wrote:

> I did stop and reconsider your suggestion about removing the star server's 
> redundant decrypt/re-encrypt step.  It could be done without introducing a 
> ppp layer (which has several of the aforementioned design requirements 
> problems I won't go into here).  Unfortunately, if I did that, the initial 
> handshaking a client box does with the star server (to identify itself and 
> the type of connection it wants to make, etc) wouldn't be encrypted or 
> cryptographically verified either (unless I did it myself, and right now all 
> the encryption is neatly handled by ssh, which I already mentioned not 
> wanting to modify).

That's not correct... if you set the encryption type to none the
connection and port forwarding are not encrypted, but the handshake still
is, using password, host key, or requiring both. You can make a fully
authenticated non-encrypted connection. I like running the popular "sleep"
program as the main command, and using port forwarding for what you do,
since you reject running ppp over ssh.

I'm running 19-pre10ac2+smp patches, as I recall ac4 or 5 are out, I just
stopped upgrading when I got stability. If you run uni you should be able
to drop in the new kernel, push the excryption overhead to the endpoints,
and have nearly no work on the star server.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

