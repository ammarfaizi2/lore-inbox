Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSHGBYg>; Tue, 6 Aug 2002 21:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316715AbSHGBYg>; Tue, 6 Aug 2002 21:24:36 -0400
Received: from goshen.rutgers.edu ([165.230.180.150]:55273 "HELO
	goshen.rutgers.edu") by vger.kernel.org with SMTP
	id <S316705AbSHGBYf>; Tue, 6 Aug 2002 21:24:35 -0400
Date: Tue, 6 Aug 2002 21:26:27 -0400 (EDT)
From: Vasisht Tadigotla <vasisht@eden.rutgers.edu>
To: linux-kernel@vger.kernel.org
Subject: multiple connect on a socket
Message-ID: <Pine.GSO.4.21.0208062103210.4158-100000@er3.rutgers.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

i'm doing the following steps,

1. open a socket on some remote server
2. set it to be non-blocking
3. connect to that socket
4. do a select on the socket
5. read from the socket
6. connect to the socket again
7. read from the socket

and as expected a EINPROGRESS error is thrown on step 3. After I do a
select() and read from that socket, I try to connect to it again and it
connects without throwing an EISCONN error in linux, though if I try to
read from it it throws a EAGAIN error. Shouldn't it throw an error when I
try to connect to it a second time ? Am I missing something here.


Vasisht



