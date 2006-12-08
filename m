Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1164182AbWLHAEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1164182AbWLHAEz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 19:04:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1164192AbWLHAEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 19:04:55 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:59019 "EHLO e3.ny.us.ibm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1164182AbWLHAEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 19:04:53 -0500
Subject: cfq performance gap
From: Avantika Mathur <mathur@us.ibm.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 07 Dec 2006 16:03:20 -0800
Message-Id: <1165536200.25180.1.camel@dyn9047017105.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens, 

I've noticed a performance gap between the cfq scheduler and other io
schedulers when running the rawio benchmark. 
Results from rawio on 2.6.19, cfq and noop schedulers: 

CFQ: 

procs           device    num read   KB/sec     I/O Ops/sec 
-----  ---------------  ----------  -------  -------------- 
  16         /dev/sda       16412     8338            2084 
-----  ---------------  ----------  -------  -------------- 
  16                        16412     8338            2084 

Total run time 0.492072 seconds 


NOOP: 

procs           device    num read   KB/sec     I/O Ops/sec 
-----  ---------------  ----------  -------  -------------- 
  16         /dev/sda       16399    29224            7306 
-----  ---------------  ----------  -------  -------------- 
  16                        16399    29224            7306 

Total run time 0.140284 seconds 

The benchmark workload is 16 processes running 4k random reads. 

Is this performance gap a known issue? 
Thanks, 
Avantika Mathur 


