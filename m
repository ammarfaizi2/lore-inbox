Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266065AbTFWQcd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 12:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbTFWQcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 12:32:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:21390 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S266065AbTFWQc0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 12:32:26 -0400
Message-ID: <3EF72F44.1040109@austin.ibm.com>
Date: Mon, 23 Jun 2003 11:48:04 -0500
From: Steven Pratt <slpratt@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20021120 Netscape/7.01
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ext3 sequential write thoughput degrades in 2.5.72-mm1
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compared with 2.5.72 the mm1 tree drops off on sequential write 
throughput for ext3. All other filesystems seem unaffected.  This 
degrade stays in mm2 and mm3.  Do not have the data from 2.5.73 yet.
Full data can be found at:
http://ltcperf.ncsa.uiuc.edu/data/2.5.72-mm1/2.5.72-vs-2.5.72-mm1/

                                     tolerance = 1.00 + 3.00% of 2.5.72
                 2.5.72   2.5.72-mm1
    Theads      MBs/sec      MBs/sec    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1        42.98        43.54     1.30         0.56         2.29
        16        11.04         6.08   -44.93        -4.96         1.33  *
        64         3.88         2.61   -32.73        -1.27         1.12  *


Results:Sequential Write CPU (Graph)
 
                                     tolerance = 1.00 + 3.00% of 2.5.72
                 2.5.72   2.5.72-mm1
    Theads         %CPU         %CPU    %diff         diff    tolerance
---------- ------------ ------------ -------- ------------ ------------
         1       53.32%       51.76%    -2.93        -1.56         2.60
        16       119.6%       86.11%   -28.00       -33.49         4.59  *
        64       37.23%       25.05%   -32.72       -12.18         2.12  *


