Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263576AbTCUK0P>; Fri, 21 Mar 2003 05:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263578AbTCUK0P>; Fri, 21 Mar 2003 05:26:15 -0500
Received: from m029-045.nv.iinet.net.au ([203.217.29.45]:46468 "EHLO
	enki.rimspace.net") by vger.kernel.org with ESMTP
	id <S263576AbTCUK0O>; Fri, 21 Mar 2003 05:26:14 -0500
To: linux-kernel@vger.kernel.org
Subject: Linux <-> Linux NFS issues.
From: Daniel Pittman <daniel@rimspace.net>
Date: Fri, 21 Mar 2003 21:37:13 +1100
Message-ID: <87isudm2ee.fsf@enki.rimspace.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) XEmacs/21.5 (cabbage)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am sharing large volume data between two Linux machines using NFS v3,
and have a bit of a reliability issue with it, with writes on the client
machine failing occasionally.


The server is running:
Linux gavroche 2.5.64 #2 Fri Mar 7 20:11:43 EST 2003

The client is running:
Linux anu 2.5.64 #6 Mon Mar 17 19:08:37 EST 2003

Both are .64 + a few csets after that, but the problem was evident with
.62 or so as well.  I am not confident enough to say it started then,
though, as I believe it happened with an earlier version on the client.


The client machine reports, in dmesg:

NFS: server cheating in read reply: count 4096 > recvd 1000

The 'count' value is occasionally higher, but not often, and the 'recvd'
never seems to differ from 1000.


On the client, a write or close syscall returns an error, specifically
'Input/Output Error' (from perror, so -EIO is the code).


This usually happens somewhere between one and ten hours through the
encoding of a set of DV files to MPEG2, and at different spots in the
process.


Searching the archives shows that this problem has been seen before, but
didn't turn up anything that was a solution.

       Daniel

-- 
Specialized meaninglessness has come to be regarded,
in some circles, as a kind of hallmark of true science.
        -- Aldous Huxley
