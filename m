Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130024AbRAISST>; Tue, 9 Jan 2001 13:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129818AbRAISSJ>; Tue, 9 Jan 2001 13:18:09 -0500
Received: from serval.noc.ucla.edu ([169.232.10.12]:39364 "EHLO
	serval.noc.ucla.edu") by vger.kernel.org with ESMTP
	id <S129595AbRAISR7>; Tue, 9 Jan 2001 13:17:59 -0500
Message-ID: <3A5B558E.553A314B@ucla.edu>
Date: Tue, 09 Jan 2001 10:16:46 -0800
From: Benjamin Redelings I <bredelin@ucla.edu>
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Subtle MM bug - 2 errors in MM code in pre-2.4.1?
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi - 
	Based on my quick reading of this patch:
+
+empty:
+	spin_lock(&mmlist_lock);
+	return 0;

The above should actually be spin_UNlock?

Also the test for !inactive_shortage() seems to be inverted?

+		/* If refill_inactive_scan failed, try to page stuff out.. */
+		swap_out(priority, gfp_mask);
+	} while (!inactive_shortage());

-BenRI
-- 
"...assisted of course by pride, for we teach them to describe the
 Creeping Death, as Good Sense, or Maturity, or Experience." 
- "The Screwtape Letters"
Benjamin Redelings I      <><     http://www.bol.ucla.edu/~bredelin/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
