Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264301AbTEOW5P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 18:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTEOW5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 18:57:15 -0400
Received: from hera.cwi.nl ([192.16.191.8]:60583 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S264298AbTEOW5N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 18:57:13 -0400
From: Andries.Brouwer@cwi.nl
Date: Fri, 16 May 2003 01:10:01 +0200 (MEST)
Message-Id: <UTC200305152310.h4FNA1X19100.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, James.Bottomley@steeleye.com
Subject: Re: [patch] NCR5380.c fix
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> any reason not to use the newly minted SAM_STAT_GOOD and
> SAM_STAT_CHECK_CONDITION?

(i) this brings NCR5380.c a tiny little bit closer to sun3_NCR5380.c
(ii) I am not so happy with SAM_STAT_GOOD etc.

Maybe it is just me, but I do not immediately think of SCSI given SAM.
We have sym_defs.h with

#define S_GOOD          (0x00)
#define S_CHECK_COND    (0x02)
...

and aiclib.h with

#define SCSI_STATUS_OK                  0x00
#define SCSI_STATUS_CHECK_COND          0x02
...

and scsi.h with

#define SAM_STAT_GOOD            0x00
#define SAM_STAT_CHECK_CONDITION 0x02
...

I wouldn't mind merging these three and choosing the SCSI_STATUS_ prefix.

Andries
