Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263971AbTEGQVE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263976AbTEGQVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:21:04 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19891 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263971AbTEGQVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:21:03 -0400
Message-Id: <200305071633.h47GXWW15850@mail.osdl.org>
Date: Wed, 7 May 2003 09:33:29 -0700 (PDT)
From: markw@osdl.org
Subject: OSDL DBT-2 AS vs. Deadline 2.5.68-mm2
To: akpm@digeo.com
cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've collected some data from STP to see if it's useful or if there's
anything else that would be useful to collect. I've got some tests
queued up for the newer patches, but I wanted to put out what I had so
far.


METRICS OVER LAST 20 MINUTES:
--------------- -------- ----- ---- -------- -----------------------------------
Kernel          Elevator NOTPM CPU% Blocks/s URL                                
--------------- -------- ----- ---- -------- -----------------------------------
2.5.68-mm2      as        1155 94.3   8940.2 http://khack.osdl.org/stp/271356/  
2.5.68-mm2      deadline  1255 94.9   9598.7 http://khack.osdl.org/stp/271359/  

FUNCTIONS SORTED BY TICKS:
-- ------------------------- ------- ------------------------- -------
 # as 2.5.68-mm2             ticks   deadline 2.5.68-mm2       ticks  
-- ------------------------- ------- ------------------------- -------
 1 default_idle              6103428 default_idle              5359025
 2 bounce_copy_vec             86272 bounce_copy_vec             97696
 3 schedule                    63819 schedule                    70114
 4 __make_request              30397 __blk_queue_bounce          31167
 5 __blk_queue_bounce          26962 scsi_request_fn             26623
 6 scsi_request_fn             24845 __make_request              25012
 7 do_softirq                  21122 do_softirq                  24623
 8 scsi_end_request            14080 system_call                 13056
 9 system_call                 12059 try_to_wake_up              12503
10 try_to_wake_up              11240 dio_bio_end_io              11511

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x 32 (office)
(503)-626-2436      (fax)
http://www.osdl.org/archive/markw/
