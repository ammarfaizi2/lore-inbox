Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129126AbRBHXKu>; Thu, 8 Feb 2001 18:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129197AbRBHXKl>; Thu, 8 Feb 2001 18:10:41 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:56337 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129126AbRBHXKV>; Thu, 8 Feb 2001 18:10:21 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: bidirectional named pipe?
Date: 8 Feb 2001 15:10:08 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <95v90g$ke6$1@cesium.transmeta.com>
In-Reply-To: <E14OxTz-0007yS-00@the-village.bc.nu> <3A81D5B4.9CBC9B0D@kasey.umkc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3A81D5B4.9CBC9B0D@kasey.umkc.edu>
By author:    "David L. Nicol" <david@kasey.umkc.edu>
In newsgroup: linux.dev.kernel
> 
> How hard would it be to add? The limitation on fifos that you get the same
> one every time you open it makes some things tricky -- the server has to
> move the fifo and mkfifo a new one to replace its data with something else,
> for instance, which is not atomic.
> 
> I don't understand, in the original problem, how the server opens
> the named bipipe differently from the servers, to be on one end rather than
> the other.
> 
> A way to map a file name to a socket pair would be nice, the first to open
> it could get one end of it and everyone else would get the other end, or there
> would be a switch.
> 
> You could patch the file system code, I wonder how deep the changes would have
> to be, if you did it in terms of lots of fifos.
> 

I would really like it if open() on a socket would be the same thing
to connect to a socket as a client.  I don't think it's a good idea to
do that for the server side, though, since it would have to know about
accept() anyway.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
