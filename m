Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265243AbUATAd2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 19:33:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265173AbUATA13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 19:27:29 -0500
Received: from fw.osdl.org ([65.172.181.6]:52180 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265062AbUATAFy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 19:05:54 -0500
Message-Id: <200401200005.i0K05do05666@mail.osdl.org>
Date: Mon, 19 Jan 2004 16:05:34 -0800 (PST)
From: markw@osdl.org
Subject: DBT-2 anticipatory scheduler and filesystem results with 2.6.1
To: piggin@cyberone.com.au
cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

I ran some dbt-2 tests against 5 filesystems with 2.6.1-mm4 and 2.6.1. I
see a degradation from 0 to 7% in throughput.  In most cases there
appears to be a significant difference in the i/o wait and user time
(for PostgreSQL) between 2.6.1 and 2.6.1-mm4, where the i/o wait time is
going up.  Thought you might be interested in the results since there
was a tuning patch in 2.6.1-mm3. I have links to more detailed results
(readprofile) here:
	http://developer.osdl.org/markw/fs/project_results.html

but here's a summary:

		% throughput change from 2.6.1 to 2.6.1-mm4
ext2		-5.9%
ext3		-5.1%
jfs		-7.0%
reiserfs	-2.2%
xfs		-0.3%

-- 
Mark Wong - - markw@osdl.org
Open Source Development Lab Inc - A non-profit corporation
12725 SW Millikan Way - Suite 400 - Beaverton, OR 97005
(503) 626-2455 x 32 (office)
(503) 626-2436      (fax)
http://developer.osdl.org/markw/
