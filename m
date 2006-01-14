Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423110AbWANFaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423110AbWANFaV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 00:30:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423114AbWANFaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 00:30:21 -0500
Received: from uproxy.gmail.com ([66.249.92.193]:25790 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1423110AbWANFaU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 00:30:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PHp83dTOfPOw/DotjE4xjr4nIWMmaVCTAE8yK1IVDrH9LuZFOY1X2SDlqeyuQernL+0PLE2XpUPBt4Du8LPXrdvI8CO+Y1RaoEV49ZSUJc022dzrXumUP5WGOxpLJvfR/8wbSC010jLPZUGlqdA4rTdMPjnSP0aToM2rR83Ppy8=
Message-ID: <5d75f4610601132130s4870d9eaq9261450905d6b888@mail.gmail.com>
Date: Sat, 14 Jan 2006 12:30:18 +0700
From: BuraphaLinux Server <buraphalinuxserver@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: nlm_udpport vs. udpport vs lockd.nlm_udpport vs etc.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am attempting to setup a firewall for an NFS v3 server.  I need to know where
the lockd ports will be.  I have added an append line to my lilo.conf
that looks like
this, and it was working in the 2.4 kernels:

append="lockd.nlm_udpport=32768 lockd.nlm_tcpport=32768"

I am using kernel 2.6.15 from ftp.kernel.org and I am trying to learn
what to do.
But the file fs/lockd/svc.c seems to want this without the 'lock.' in front.
But the file Documentation/kernel-parameters.txt suggests
lockd.udpport and lockd.tcpport (no "nlm_").

1.  Why do the files in the kernel disagree with each other?
2.  What do I really need on my append="" line, or is there some other
     way to set this now?
3.  Should I hardcode the ports in the kernel source code and recompile?

Thank you,

JGH
