Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161151AbVIPKIP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161151AbVIPKIP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 06:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbVIPKIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 06:08:15 -0400
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:57763 "HELO ncic.ac.cn")
	by vger.kernel.org with SMTP id S1161151AbVIPKIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 06:08:14 -0400
Date: Fri, 16 Sep 2005 18:08:13 +0800
From: "Yingchao Zhou" <yc_zhou@ncic.ac.cn>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: should swap-file opened with O_DIRECT?
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20050916101009.5DDACFB04A@gatekeeper.ncic.ac.cn>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  The sys_swapon system call open the swap-file through 
filp_open(..., O_RDWR|O_LARGEFILE,...).
  In this way, I think that the pageout process of anonymous
pages finally will write them out through (swap-file)->f_ops->write,
and it will result in caches of swapfile. However, swapping only 
happens when memory is tight. So why not set O_DIRECT? Is there any
special reason to keep caches of swapfile?
  Is the idea right ? Or something misunstood? 


