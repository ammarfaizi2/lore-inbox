Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTDIBNS (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 21:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTDIBNS (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 21:13:18 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:49389 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262423AbTDIBNR (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 21:13:17 -0400
Date: Tue, 8 Apr 2003 21:21:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges (was:
  [MAILER-DAEMON@rumms.u
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304082124_MC3-1-3399-FBD0@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:


>As far as the 2.4.X series is concerned, pushing has not helped.  I've
>seen spelling fixes and incorrorct changes get accepted from non
>maintainers "instantly", while the maintainers changes are not accepted.


And your code goes for long periods of time without merging good fixes,
like this one (from 2.4.20):


--- aic7-20030310/drivers/scsi/aic7xxx/aic7770.c.orig	Mon Mar 10 20:46:36 2003
+++ aic7-20030310/drivers/scsi/aic7xxx/aic7770.c	Tue Apr  8 20:45:20 2003
@ -314,7 +314,7 @
 	if (bootverbose)
 		printf("%s: Reading SEEPROM...", ahc_name(ahc));
 	have_seeprom = ahc_read_seeprom(&sd, (uint16_t *)sc,
-					/*start_addr*/0, sizeof(sc)/2);
+					/*start_addr*/0, sizeof(*sc)/2);
 
 	if (have_seeprom) {
 


--
 Chuck
 Can't we all just get along?
