Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129458AbQLGXwz>; Thu, 7 Dec 2000 18:52:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129846AbQLGXwg>; Thu, 7 Dec 2000 18:52:36 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:14088 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S129458AbQLGXwc>; Thu, 7 Dec 2000 18:52:32 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Thu, 7 Dec 2000 16:21:58 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Cc: florian@galois.de
Subject: Re: oops in 2.4.0test12-pre5+reiserfs+crypto
MIME-Version: 1.0
Message-Id: <00120716215803.01067@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Florian Schmitt <florian@galois.de> wrote:
>I had the following oops while doing a "find -name" and playing mp3s on 

If you're running 2.4.0-test12-pre5 or later with reiserfs, you should be 
aware that this can be unsafe due to a problem with reiserfs_writepage.
Fortunately, Chris Mason just posted a patch to fix this on the reiserfs-list,
against reiserfs-3.6.22.  The recent reiserfs-list archives can be found at:

http://marc.theaimsgroup.com/?l=reiserfs&r=1&w=2&b=200012

This may have nothing to do with your oops, but if you're going to run
2.4.0-test12-pre5,6,7 then go get the writepage.diff patch, and apply it
after applying linux-2.4.0-test10-reiserfs-3.6.22-patch.

Of course, this is bleeding edge, so the usual caveats apply.

Good luck,
Steven
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
