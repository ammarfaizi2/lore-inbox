Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131657AbRAIT37>; Tue, 9 Jan 2001 14:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131777AbRAIT3t>; Tue, 9 Jan 2001 14:29:49 -0500
Received: from mailer.psc.edu ([128.182.58.100]:27915 "EHLO mailer.psc.edu")
	by vger.kernel.org with ESMTP id <S131266AbRAIT3i>;
	Tue, 9 Jan 2001 14:29:38 -0500
Date: Tue, 9 Jan 2001 14:29:36 -0500 (EST)
From: John Heffner <jheffner@psc.edu>
To: Tim Sailer <sailer@bnl.gov>
cc: linux-kernel@vger.kernel.org
Subject: Re: Network Performance?
In-Reply-To: <20010109115302.A32135@bnl.gov>
Message-ID: <Pine.NEB.4.05.10101091423060.3675-100000@dexter.psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Tim Sailer wrote:

> Here is some more data:
> 
>         Inbound = 99.66 kB/s
>         Outbound= 151 kB/s
> 
> 
> --------------------------------------------
> ports:/home/ftp# sysctl -a | fgrep net/core
> net/core/optmem_max = 10240
> net/core/message_burst = 50
> net/core/message_cost = 5
> net/core/netdev_max_backlog = 300
> net/core/rmem_default = 32767			<<<<<<<<<
> net/core/wmem_default = 32767			<<<<<<<<<
> net/core/rmem_max = 2097152
> net/core/wmem_max = 2097152
> --------------------------------------------

The defaults must be large unless your application calls setsockopt() to
set the buffers itself.  (Some FTP clients and servers can do this, but
for testing, your're still probably better always having the _max's and
_default's the same.)

  -John

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
