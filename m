Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280701AbRKFXq2>; Tue, 6 Nov 2001 18:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280695AbRKFXoc>; Tue, 6 Nov 2001 18:44:32 -0500
Received: from [216.102.46.130] ([216.102.46.130]:62012 "EHLO
	zinfandel.topspincom.com") by vger.kernel.org with ESMTP
	id <S280709AbRKFXoK>; Tue, 6 Nov 2001 18:44:10 -0500
To: <imran.badr@cavium.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel 2.4 and TCP terminations per second.
In-Reply-To: <017e01c1671b$91ab38e0$3b10a8c0@IMRANPC>
From: Roland Dreier <roland@topspincom.com>
Date: 06 Nov 2001 15:43:36 -0800
In-Reply-To: "Imran Badr"'s message of "Tue, 6 Nov 2001 15:34:23 -0800"
Message-ID: <521yjb5utz.fsf@love-boat.topspincom.com>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Imran> I am running openssl with apache using modssl. I will have
    Imran> to look at whether could I use openssl with TUX or zeus.

If you are doing SSL termination without a hardware crypto accelerator
then the cost of the public key operations for the SSL handshake will
far outweigh the cost of TCP termination and the webserver.  With a
typical machine (say a 1 GHz P3) I would estimate you could do 200 SSL
handshakes/sec with apache/modssl (with 95% of your CPU time spent in
OpenSSL RSA code).  With a hardware crypto accelerator you could get
up to 600-1000 handshakes/sec but the crypto will still be the
bottleneck.

Roland

