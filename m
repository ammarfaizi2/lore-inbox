Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265568AbUANL3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 06:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUANL3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 06:29:23 -0500
Received: from amsfep14-int.chello.nl ([213.46.243.22]:38196 "EHLO
	amsfep14-int.chello.nl") by vger.kernel.org with ESMTP
	id S265568AbUANL3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 06:29:22 -0500
Date: Wed, 14 Jan 2004 12:29:20 +0100
From: Haakon Riiser <hakonrk@ulrik.uio.no>
To: linux-kernel@vger.kernel.org
Subject: Re: Busy-wait delay in qmail 1.03 after upgrading to Linux 2.6
Message-ID: <20040114112920.GB298@s.chello.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040113210923.GA955@s.chello.no> <20040113135152.3ed26b85.akpm@osdl.org> <20040113232624.GA302@s.chello.no> <20040113154348.5542cb7b.akpm@osdl.org> <20040114000746.GA691@s.chello.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114000746.GA691@s.chello.no>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have some more info on this bug:

Apparently, lock/trigger is a named pipe that connects to
qmail-send.  I immediately tried stracing qmail-send while sending
the test message, but unfortunately, the bug is not reproducible
while qmail-send is straced.  The entire process is almost as
fast as it is under 2.4 when I strace qmail-send.

At least now we have a temporary workaround:

  strace -p $(pidof qmail-send) -o /dev/null &

:-)

Btw, the output from strace -p $(pidof qmail-send) can be viewed here:
(probably not interesting though, since the bug is not reproduced
under strace)

  http://home.chello.no/~hakonrk/qmail-send.st.out.gz

-- 
 Haakon
