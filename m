Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264385AbUEIUzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264385AbUEIUzH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 16:55:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264386AbUEIUzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 16:55:07 -0400
Received: from bay1-f96.bay1.hotmail.com ([65.54.245.96]:46341 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264385AbUEIUzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 16:55:03 -0400
X-Originating-IP: [212.179.89.182]
X-Originating-Email: [rimaherm@hotmail.com]
From: "Rimaher Molanski" <rimaherm@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: releasing page cached pages in 2.4.20
Date: Sun, 09 May 2004 20:55:02 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY1-F96fdH8hOY0luQ0000a23c@hotmail.com>
X-OriginalArrivalTime: 09 May 2004 20:55:02.0602 (UTC) FILETIME=[E614F2A0:01C43607]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm conducting a small analysis of cache algorithms, and have run into 
problems trying to implement cache eviction in 2.4.20 kernel.   I call 
try_to_release_page (with GFP_NOIO flag) on pages that aren't referenced by 
anything other than page cache and sometimes also the buffer cache.  I 
sometimes do this call from inside the scheduler tq (a task_schedule 
function), if this is relevant.

Anyway, in certain scenarios I get deadlocked on the text.lock.buffer lock, 
and I have no idea which locks I must obtain (or any other prerequisites) 
before I can safely call try_to_release_page. Can anyone help on the 
requirements?  Also, is there a simpler function I could call to get the job 
done?

Thanks,
Rimaher.

_________________________________________________________________
FREE pop-up blocking with the new MSN Toolbar – get it now! 
http://toolbar.msn.com/go/onm00200415ave/direct/01/

