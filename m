Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263730AbRFELMU>; Tue, 5 Jun 2001 07:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263852AbRFELMA>; Tue, 5 Jun 2001 07:12:00 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:56330 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S263730AbRFELLv>; Tue, 5 Jun 2001 07:11:51 -0400
Date: Tue, 5 Jun 2001 21:11:19 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Martin Clausen <martin@ostenfeld.dk>
cc: <netfilter-devel@lists.samba.org>, <linux-kernel@vger.kernel.org>
Subject: Re: No buffer space available when using the ip_queue module
In-Reply-To: <20010605111513.D978@ostenfeld.dk>
Message-ID: <Pine.LNX.4.31.0106052107230.9305-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001, Martin Clausen wrote:

> Hi!
>
> When using the ip_queue module from Netfilter I sometimes get this error:
>
> Failed to receive netlink message: No buffer space available
>
> Is it possible to make those kernel buffers bigger so that I don't run
> into this problem?
>

Yes, these are standard Netlink sockets, and you can tune their receive
buffer sizes via /proc, or use the SO_RCVBUF socket option on the file
descriptor.

- James
-- 
James Morris
<jmorris@intercode.com.au>


