Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264813AbTB0MZd>; Thu, 27 Feb 2003 07:25:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264820AbTB0MZd>; Thu, 27 Feb 2003 07:25:33 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:65420 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id <S264813AbTB0MZb>;
	Thu, 27 Feb 2003 07:25:31 -0500
Date: Thu, 27 Feb 2003 13:35:31 +0100
From: Roger Luethi <rl@hellgate.ch>
To: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@digeo.com>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>
Subject: [3/2][via-rhine][PATCH] fixing the reset fix
Message-ID: <20030227123531.GA5366@k3.hellgate.ch>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@digeo.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20030227114417.GA3970@k3.hellgate.ch>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.63 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Bad semicolon in previous patch ([1/2]). Thanks to
Erik@harddisk-recovery.nl for spotting this.


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="via-rhine-1.17rc-03_reset_trivial.diff"

--- 08_tdwb_race/drivers/net/via-rhine.c	Thu Feb 27 11:45:47 2003
+++ 09_reset_trivial/drivers/net/via-rhine.c	Thu Feb 27 13:27:00 2003
@@ -562,7 +562,7 @@ static void wait_for_reset(struct net_de
 
 		/* VT86C100A may need long delay after reset (dlink) */
 		/* Seen on Rhine-II as well (rl) */
-		while ((readw(ioaddr + ChipCmd) & CmdReset) && --boguscnt);
+		while ((readw(ioaddr + ChipCmd) & CmdReset) && --boguscnt)
 			udelay(5);
 
 	}

--MGYHOYXEY6WxJCY8--
