Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131474AbQKJTjB>; Fri, 10 Nov 2000 14:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131480AbQKJTiv>; Fri, 10 Nov 2000 14:38:51 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:13582 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S131474AbQKJTih>; Fri, 10 Nov 2000 14:38:37 -0500
Message-ID: <3A0C4DD0.DE90E364@timpanogas.org>
Date: Fri, 10 Nov 2000 12:34:40 -0700
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <3A0C4252.100D863D@timpanogas.org> <20001110203506.A1028@inspiron.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrea,

All done.  It's already setup this way.

Jeff

Andrea Arcangeli wrote:
> 
> On Fri, Nov 10, 2000 at 11:45:39AM -0700, Jeff V. Merkey wrote:
> > > > > > [..]  Issuing the command "sendmail -v
> > > > > > -q" does not flush the mail queue. [..]
> 
> So first thing to do is to check that in /etc/sendmail.cf this line is
> commented out this way:
> 
> #O HostStatusDirectory=...
> 
> (if you build .cf via m4 add this line:
> 
> undefine(`confHOST_STATUS_DIRECTORY')dnl
> 
> and rebuild the .cf from the m4 source)
> 
> Then `rcsendmail reload; sendmail -q; mailq`.
> 
> Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
