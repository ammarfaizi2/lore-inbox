Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbVKEOVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbVKEOVp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 09:21:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVKEOVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 09:21:45 -0500
Received: from main.gmane.org ([80.91.229.2]:63391 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751168AbVKEOVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 09:21:44 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Peter Daum <gator_ml@yahoo.de>
Subject: scsi_eh_x/scsi_wq_x "zombie" processes in kernel 2.6.13+
Date: Sat, 05 Nov 2005 13:17:39 +0100
Message-ID: <dki7t4$utu$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9537492.dip.t-dialin.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050314 Mnenhy/0.7.1
X-Accept-Language: de, en, fr, es, pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Starting around kernel version 2.6.13, the scsi_eh_x and scsi_wq_x
processes that are created per scsi host will not terminate if the
driver for the scsi interface is removed. I don't know whether there
are any serious problems involved with this, but one thing that is
definitely annoying, is that the process list fills very quickly when
modules are loaded/unloaded on demand, because 2 new processes will
be created every time the driver for a scsi adapter gets loaded.

(I guess, this happens with all scsi host modules - in my case, the
"culprit" is a qlogic fibre channel driver that gets loaded only when
needed.)

Regards,
              Peter Daum

