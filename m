Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261645AbUJaOqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbUJaOqC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 09:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbUJaOpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 09:45:17 -0500
Received: from baikonur.stro.at ([213.239.196.228]:4743 "EHLO baikonur.stro.at")
	by vger.kernel.org with ESMTP id S261635AbUJaOpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 09:45:02 -0500
Date: Sun, 31 Oct 2004 15:44:42 +0100
From: maximilian attems <janitor@sternwelten.at>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Margit Schubert-While <margitsw@t-online.de>,
       Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
       mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
       netdev@oss.sgi.com, Domen Puncer <domen@coderock.org>,
       linux-kernel@vger.kernel.org
Subject: [patch 2/6] libata remove duplicate definition msecs_to_jiffies()
Message-ID: <20041031144442.GC28667@stro.at>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Margit Schubert-While <margitsw@t-online.de>,
	Nishanth Aravamudan <nacc@us.ibm.com>, hvr@gnu.org,
	mcgrof@studorgs.rutgers.edu, kernel-janitors@lists.osdl.org,
	netdev@oss.sgi.com, Domen Puncer <domen@coderock.org>,
	linux-kernel@vger.kernel.org
References: <20040923221303.GB13244@us.ibm.com> <20040923221303.GB13244@us.ibm.com> <5.1.0.14.2.20040924074745.00b1cd40@pop.t-online.de> <415CD9D9.2000607@pobox.com> <20041030222228.GB1456@stro.at> <41841886.2080609@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41841886.2080609@pobox.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



remove duplicate definition of msecs_to_jiffies().
already includes delay.h

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>


---

 linux-2.4.28-rc1-max/include/linux/libata.h |    5 -----
 1 files changed, 5 deletions(-)

diff -puN include/linux/libata.h~remove-msecs_to_jiffies-libata.h include/linux/libata.h
--- linux-2.4.28-rc1/include/linux/libata.h~remove-msecs_to_jiffies-libata.h	2004-10-31 13:33:52.000000000 +0100
+++ linux-2.4.28-rc1-max/include/linux/libata.h	2004-10-31 13:36:16.000000000 +0100
@@ -419,11 +419,6 @@ extern int ata_std_bios_param(Disk * dis
 extern void libata_msleep(unsigned long msecs);
 
 
-static inline unsigned long msecs_to_jiffies(unsigned long msecs)
-{
-	return ((HZ * msecs + 999) / 1000);
-}
-
 static inline unsigned int ata_tag_valid(unsigned int tag)
 {
 	return (tag < ATA_MAX_QUEUE) ? 1 : 0;
_
