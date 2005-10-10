Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbVJJNqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbVJJNqu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 09:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbVJJNqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 09:46:50 -0400
Received: from gatekeeper.ncic.ac.cn ([159.226.41.188]:17086 "HELO ncic.ac.cn")
	by vger.kernel.org with SMTP id S1750801AbVJJNqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 09:46:49 -0400
Date: Mon, 10 Oct 2005 21:46:31 +0800
From: "Yingchao Zhou" <yc_zhou@ncic.ac.cn>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [RFC]should swap-file opened with O_DIRECT?
X-mailer: Foxmail 5.0 [cn]
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit
Message-Id: <20051010135229.D29B5FB048@gatekeeper.ncic.ac.cn>
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

							Yingchao Zhou
							yc_zhou@ncic.ac.cn


