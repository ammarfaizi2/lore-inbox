Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263537AbTIWTfq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 15:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263533AbTIWTfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 15:35:46 -0400
Received: from itaqui.terra.com.br ([200.176.3.19]:50845 "EHLO
	itaqui.terra.com.br") by vger.kernel.org with ESMTP id S263496AbTIWTfh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 15:35:37 -0400
Message-ID: <3F7096EE.8080105@terra.com.br>
Date: Tue, 23 Sep 2003 15:54:38 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: James.Bottomley@SteelEye.com
Cc: linux-scsi@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Memory leak in scsi_debug found by checker
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi James,

	Patch against 2.6-test5.

	If in the middle of loop a kmalloc failed, that means that the 
previous calls succeeded..so they must be also be freed (and removed 
from the dev_info_list).

	Please review and consider applying.

	Cheers,

Felipe

