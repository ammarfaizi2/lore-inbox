Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267033AbSK2NKF>; Fri, 29 Nov 2002 08:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267036AbSK2NKF>; Fri, 29 Nov 2002 08:10:05 -0500
Received: from carlsberg.amagerkollegiet.dk ([194.182.238.3]:65041 "EHLO
	carlsberg.amagerkollegiet.dk") by vger.kernel.org with ESMTP
	id <S267033AbSK2NKE> convert rfc822-to-8bit; Fri, 29 Nov 2002 08:10:04 -0500
Date: Fri, 29 Nov 2002 14:17:25 +0100 (CET)
From: =?iso-8859-1?Q?Rasmus_B=F8g_Hansen?= <moffe@amagerkollegiet.dk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PROBLEM] NFS trouble - file corruptions
In-Reply-To: <15846.25140.759632.709205@charged.uio.no>
Message-ID: <Pine.LNX.4.44.0211291410240.29442-100000@grignard.amagerkollegiet.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Nov 2002, Trond Myklebust wrote:

> >>>>> " " == Rasmus Bøg Hansen <moffe@amagerkollegiet.dk> writes:
>
>     >> Does it also occur if you play around with setting rsize and
>     >> wsize = 1024?
>
>      > I'm afraid so - I just double-checked...
>
> Given that you are saying that even synchronous RPC (which is the
> default for r/wsize = 1024) is failing, then my 2 main suspicions are
>
>   - hardware failure: Have you tried this on several different
>     server/client combinations and hardware combinations?

Sigh:

Just tried reversing the process (ie. exchanging the client/server
role): No trouble at all, no errors in files.

I just tried turning off DMA on the server disk (this is just a low-end
IDE-system): No errors in files (compressing the file thrice).

So it does not at all seem to be a NFS-issue!

I have no idea what is wrong. If the disk, cable or IDE controller does
bit-flipping when DMA is turned on, why is the problem only seen with
NFS? I have never seem corrupted files or metadata with DMA turned
(except once long ago, when I experimented with high-transfer-modes - I
haven't done that since)...

Thanks for your help!

Regards
/Rasmus

(damn, PIO-mode performance sucks!)

-- 
-- [ Rasmus "Møffe" Bøg Hansen ] ---------------------------------------
He who asks a question is a fool for five minutes; he who does not ask a
question remains a fool forever.
----------------------------------[ moffe at amagerkollegiet dot dk ] --

