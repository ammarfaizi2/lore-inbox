Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTFIW4c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 18:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbTFIW4c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 18:56:32 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:16092 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262261AbTFIW4Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 18:56:25 -0400
Message-ID: <3EE5190D.3070401@austin.ibm.com>
Date: Mon, 09 Jun 2003 18:32:29 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.5.70-mm2 causes performance drop of random read O_DIRECT
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting in 2.5.70-mm2 and continuing in the mm tree, there is a 
significant degrade in random read for block devices using O_DIRECT.   
 The drop occurs for all block sizes and ranges from 30%-40.  CPU usage 
is also lower although it may already be so low as to be irrelavent.


                                 tolerance = 0.00 + 3.00% of 2.5.70-mm1
             2.5.70-mm1   2.5.70-mm2
 Blocksize      KBs/sec      KBs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
      4096         1567          924   -41.03      -643.00        47.01  * 
      8192         3057         1815   -40.63     -1242.00        91.71  * 
     16384         5745         3509   -38.92     -2236.00       172.35  * 
     65536        17357        11283   -34.99     -6074.00       520.71  * 
    262144        37537        27302   -27.27    -10235.00      1126.11  * 


Full results can be found at:
http://www-124.ibm.com/developerworks/oss/linuxperf/regression/2.5.70-mm2/2.5.70-mm1-vs-2.5.70-mm2/

Steve

