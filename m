Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131550AbQKJTfv>; Fri, 10 Nov 2000 14:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130143AbQKJTfn>; Fri, 10 Nov 2000 14:35:43 -0500
Received: from Cantor.suse.de ([194.112.123.193]:64271 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131591AbQKJTfO>;
	Fri, 10 Nov 2000 14:35:14 -0500
Date: Fri, 10 Nov 2000 20:35:06 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Message-ID: <20001110203506.A1028@inspiron.suse.de>
In-Reply-To: <3A0C4252.100D863D@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A0C4252.100D863D@timpanogas.org>; from jmerkey@timpanogas.org on Fri, Nov 10, 2000 at 11:45:39AM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 11:45:39AM -0700, Jeff V. Merkey wrote:
> > > > > [..]  Issuing the command "sendmail -v
> > > > > -q" does not flush the mail queue. [..]

So first thing to do is to check that in /etc/sendmail.cf this line is
commented out this way:

#O HostStatusDirectory=...

(if you build .cf via m4 add this line:

undefine(`confHOST_STATUS_DIRECTORY')dnl

and rebuild the .cf from the m4 source)

Then `rcsendmail reload; sendmail -q; mailq`.

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
