Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbULVOGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbULVOGG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 09:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261840AbULVOGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 09:06:06 -0500
Received: from webmail.sub.ru ([213.247.139.22]:59397 "HELO techno.sub.ru")
	by vger.kernel.org with SMTP id S261823AbULVOF7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 09:05:59 -0500
From: Mikhail Ramendik <mr@ramendik.ru>
To: linux-kernel@vger.kernel.org
Subject: kswapd cpu-eating FIXED by Andrew's patch!
Date: Wed, 22 Dec 2004 17:05:45 +0300
User-Agent: KMail/1.7.1
Cc: akpm@osdl.org, Voluspa <lista4@comhem.se>,
       Con Kolivas <kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412221705.45237.mr@ramendik.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

While Con's token-disable patch has fixed the screen freezes, the kswapd CPU 
load issue at the start of a memory hog remained. 

On another matter, Andrew Morton posted this patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=110357628419245&w=2

Rik hinted that it could be the cause of the CPU eating problem. I have 
applied it (to 2.6.10-rc3 with token-disable and vm-throttling already 
applied), and - BINGO! No noticeable kswapd CPU load at all!

-- 
Yours, Mikhail Ramendik

