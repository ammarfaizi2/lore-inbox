Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264864AbTFLPYu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 11:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264865AbTFLPYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 11:24:50 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:29457 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S264864AbTFLPYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 11:24:48 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: True number of device openers in 2.5
Date: Thu, 12 Jun 2003 19:37:53 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306121937.53198.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For single-partition devices it is just bd_openers but I am more intersted in 
multi-partition case. Here I need to know about sum of opens for all 
partitions including the whole device. It appears that for a container 
bd_openers is incremented for every open of itself and for the _first_ open 
of partition and bd_part_count is incremented for every (including first) 
open of partition. So bdev->bd_contains->bd_openers + 
bdev->bd_contains->bd_part_count really gives an access (number of opened 
partitions but this is unknown otherwise).

Thank you

-andrey
