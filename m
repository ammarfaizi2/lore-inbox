Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbRAIFPZ>; Tue, 9 Jan 2001 00:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129267AbRAIFPO>; Tue, 9 Jan 2001 00:15:14 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:30471 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129226AbRAIFPA>; Tue, 9 Jan 2001 00:15:00 -0500
Date: Mon, 8 Jan 2001 23:14:43 -0600
To: "David L. Parsley" <parsley@linuxjedi.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: question on generating a patch
Message-ID: <20010108231443.B3385@cadcamlab.org>
In-Reply-To: <3A5A9444.5B2772F2@linuxjedi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5A9444.5B2772F2@linuxjedi.org>; from parsley@linuxjedi.org on Mon, Jan 08, 2001 at 11:32:04PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[David L. Parsley]
> I read the FAQ and SubmittingPatches, but how best to generate a
> patch that moves a file from on dir to another?  diff -urNP makes the
> patch a lot longer than it seems like it should be...

A major weakness of the 'patch' command -- you cannot gracefully move
or rename files.  Larry Wall saw this years ago and invented a hybrid
sort of patch that runs as a shar-like shell script, moving things
around before actually applying itself as a patch.  But most people,
including linux-kernel, don't use lwall's patch+shar format.


- If it's a fairly small file anyway, just use 'diff -urN' and don't
worry about it.

- If it's a large file or several files, or if you are making
significant changes to said files besides moving them, you should
probably list two separate steps: first, describe the rearrangement,
perhaps as a series of 'mv' commands; second, give us a patch against
the new arrangement.


Either way, you need to make it clear what changes, if any, have been
made to a particular file "in transit".  With just 'diff -urN' and no
explanation, it is hard to tell one way or the other.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
