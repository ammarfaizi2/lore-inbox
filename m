Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSFBKwb>; Sun, 2 Jun 2002 06:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317166AbSFBKwa>; Sun, 2 Jun 2002 06:52:30 -0400
Received: from mons.uio.no ([129.240.130.14]:30082 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S317165AbSFBKwa>;
	Sun, 2 Jun 2002 06:52:30 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15609.63721.842434.183988@charged.uio.no>
Date: Sun, 2 Jun 2002 12:52:25 +0200
To: Kenneth Johansson <ken@canit.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: nfs problem 2.4.19-pre9
In-Reply-To: <1022962240.1186.62.camel@tiger>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Kenneth Johansson <ken@canit.se> writes:

    >> Fair enough. Have you tried a tcpdump?

     > I can send you a trace if you want. I guess you only need a
     > trace from the first stat to read fails but it has to wait an
     > hour or two it's not a good time to crash just now.

Problem is very apparent from the tcpdump: your client is only
receiving 2 or 3 out of the 6 UDP fragments in the NFS read
reply from the server. The rest is getting lost en route.

Check out the NFS FAQ on nfs.sourceforge.net. The relevant section is
the bit that asks questions of the form:

   1) Are both server and client running on the same speed network
      (i.e. are both switched 100Mbit/100Mbit or 10Mbit/10Mbit)?
   2) If you are using a switch, are you also using autonegotiation,
      or have you forced one or both of the cards (forcing is *bad*
      if your switch/hub is autonegotiating)

Cheers,
  Trond
