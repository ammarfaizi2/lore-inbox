Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUCUWSM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 17:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbUCUWSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 17:18:00 -0500
Received: from GOL139579-1.gw.connect.com.au ([203.63.118.157]:42704 "EHLO
	goldweb.com.au") by vger.kernel.org with ESMTP id S261358AbUCUWP6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 17:15:58 -0500
Message-ID: <405E1427.6080309@stillhq.com>
Date: Mon, 22 Mar 2004 09:16:07 +1100
From: Michael Still <mikal@stillhq.com>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040306)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Makefile dependancies: scripts depending on configured kernel?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey,

the top level Makefile specifies that the scripts depend on the kernel 
being configured before the scripts can be built:

scripts: scripts_basic include/config/MARKER
	$(Q)$(MAKE) $(build)=$(@)

I think that this is probably a problem, because it means people can't 
build any of the documentation targets without having configured the kernel.

Do any of the scripts actually depend on a configured kernel to build? 
How can I verify that none of them need a configured kernel? Commenting 
out the dependancy didn't break anything.

Thanks,
Mikal

-- 

Michael Still (mikal@stillhq.com) | "All my life I've had one dream,
http://www.stillhq.com            |  to achieve my many goals"
UTC + 11                          |    -- Homer Simpson
