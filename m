Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268094AbRGVXEa>; Sun, 22 Jul 2001 19:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268096AbRGVXEU>; Sun, 22 Jul 2001 19:04:20 -0400
Received: from [217.28.130.35] ([217.28.130.35]:63755 "EHLO
	mailth4.byworkwise.com") by vger.kernel.org with ESMTP
	id <S268094AbRGVXEF>; Sun, 22 Jul 2001 19:04:05 -0400
Message-ID: <3B5B32B2.B96E6BD3@freenet.co.uk>
Date: Sun, 22 Jul 2001 21:08:18 +0100
From: Gordon Lack <gmlack@freenet.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NFSv3 pathname problems in 2.4 kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

   I am seeing a problem at the client side when trying to obtain pathnames of NFS-mounted entries.  This occurs when the NFS servers involved are Linux2.4 kernels and the clients are SGI Irix 6.5 or Solaris 2.6 (Linux 2.4 clients are Ok - 2.2 ones won't be using NFSv3).

   As an example of what happens.

o The server side has a pathname of /raid/sources/prog1 - a directory.

o /raid is exported

o The client NFS mounts /raid/sources as /projects/sources

o I cd to /projects/sources/prog1 and type /bin/pwd

   I expect to get /projects/sources/prog1 as the result, but I actually get /sources/prog1.

   Similar mounts from Linux2.2. systems (presumably running NFSv2) produce the expected (correct) result.

   I've snoop'ed the network traffic and one thing I can see is that the filehandle used in the NFSv3 mount is reported as being a different length (shorter) than those for v2.

   So,

a) has anyone else encountered these problems?

b) if so, do they have a solution?

c) how is the filehandle calculated in the 2.4 kernel for NFSv3?  Which routine is it in?  Perhaps I could try (optionally) forcing it to be the same length as a v2 filehandle to see whether that fixes things.  (I'd rather that the 2.4 kernel were optimally compatible rather than paranoically
correct.


   Hoping someone can help...
