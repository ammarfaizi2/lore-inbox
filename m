Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129661AbQKTRLk>; Mon, 20 Nov 2000 12:11:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129666AbQKTRLa>; Mon, 20 Nov 2000 12:11:30 -0500
Received: from Cantor.suse.de ([194.112.123.193]:42251 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129661AbQKTRLU>;
	Mon, 20 Nov 2000 12:11:20 -0500
To: linux-kernel@vger.kernel.org
Cc: Marco van Wieringen <mvw@planets.elm.net>
Subject: struct acct uses 16bit uids :-(
From: Andreas Jaeger <aj@suse.de>
Date: 20 Nov 2000 17:33:04 +0100
Message-ID: <u8snomhadb.fsf@gromit.rhein-neckar.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Channel Islands)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

is anybody maintaining the BSD process accounting?  It's currently
broken since it still uses 16 bit uids :-(

struct acct in <linux/acct.h> contains:
/*
 *      No binary format break with 2.0 - but when we hit 32bit uid we'll
 *      have to bite one
 */
        __u16           ac_uid;                 /* Accounting Real User ID */
        __u16           ac_gid;                 /* Accounting Real Group ID */


Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
