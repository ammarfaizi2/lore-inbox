Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUHAKTL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUHAKTL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 06:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUHAKTL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 06:19:11 -0400
Received: from justchat.medium.net ([83.120.2.52]:16301 "EHLO
	smtp.mail.service.medium.net") by vger.kernel.org with ESMTP
	id S265691AbUHAKTJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 06:19:09 -0400
Message-ID: <410CC397.6010509@baldauf.org>
Date: Sun, 01 Aug 2004 12:19:03 +0200
From: =?ISO-8859-1?Q?Xu=E2n_Baldauf?= 
	<xuan--2004.08.01--linux-kernel--vger.kernel.org@baldauf.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a2) Gecko/20040714
X-Accept-Language: de-de
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Software RAID 5 and crashes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have been extensively searching for documentation and mailing lists, 
but was yet unable to answer this question:

Does Linux software RAID 5 (or RAID 4) do ordered writes? (data stripes 
first, then parity stripes)

Because if the writes are not ordered, parity stripes could be written 
before data stripes. If the system crashes at this time, reconstruction 
will  try to reconstruct the parity stripes by using the wrong (old) 
data stripes.

If the writes are ordered, crashes after the write of the data stripe 
but before the write to the parity stripe do not harm.

Thanks,

Xuân Baldauf.

