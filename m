Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267159AbTBVSfl>; Sat, 22 Feb 2003 13:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267286AbTBVSfl>; Sat, 22 Feb 2003 13:35:41 -0500
Received: from almesberger.net ([63.105.73.239]:50695 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S267159AbTBVSfk>; Sat, 22 Feb 2003 13:35:40 -0500
Date: Sat, 22 Feb 2003 15:45:39 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Valdis.Kletnieks@vt.edu
Cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC3168, section 6.1.1.1 - ECN and retransmit of SYN
Message-ID: <20030222154539.H2791@almesberger.net>
References: <200302212125.h1LLPgxE001759@81-2-122-30.bradfords.org.uk> <1045874822.25411.3.camel@rth.ninka.net> <200302220048.h1M0mjCu020837@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302220048.h1M0mjCu020837@turing-police.cc.vt.edu>; from Valdis.Kletnieks@vt.edu on Fri, Feb 21, 2003 at 07:48:45PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
> To be honest, we don't know.  On the other hand, there's 3 basic
> classes of failure modes:

Another idea:

4) Back off quickly (i.e. disable ECN on first retry), but keep track
of whom you had to do this for. Then use some clever user-mode
strategy module to act on this information. (E.g. send a list of ECN
offenders to root, or raise the threshold value for turning off ECN
for destinations that seem to accept ECN in general, but suffer high
losses.)

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
