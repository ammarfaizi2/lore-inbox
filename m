Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266946AbRGHRmo>; Sun, 8 Jul 2001 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266944AbRGHRme>; Sun, 8 Jul 2001 13:42:34 -0400
Received: from eax.student.umd.edu ([129.2.236.2]:6673 "EHLO
	eax.student.umd.edu") by vger.kernel.org with ESMTP
	id <S266945AbRGHRm3>; Sun, 8 Jul 2001 13:42:29 -0400
Date: Sun, 8 Jul 2001 13:42:28 -0500 (EST)
From: Adam <adam@cfar.umd.edu>
X-X-Sender: <cfar@eax.student.umd.edu>
To: Chris Wedgwood <cw@f00f.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: recvfrom and sockaddr_in.sin_port
In-Reply-To: <20010709052100.E28809@weta.f00f.org>
Message-ID: <Pine.LNX.4.33.0107081338140.936-100000@eax.student.umd.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     isn't it set? to quote from the example I have attached:
>       socklen_t fromlen = sizeof(struct sockaddr_in);
> sorry, I misread the source (the memset line)
> you are using raw sockets, what does port mean for raw sockets?

well, from raw(7) man page:

       raw_socket = socket(PF_INET, SOCK_RAW, int protocol);
       [...]
       All packets [...] matching the protocol number  speci
       fied  for the raw socket are passed to this socket.

so it seem to imply that only tcp packets only are to be passed.
still group "SOCK_RAW" is subset of the PF_INET group (the way
I see it), so from ip(7) man page I should use sockaddr_in
structure, which should be defined in this particular case,
as it ought be for IPPROTO_UDP.


