Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268961AbUIQTyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268961AbUIQTyn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 15:54:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268963AbUIQTyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 15:54:43 -0400
Received: from mail43-s.fg.online.no ([148.122.161.43]:32767 "EHLO
	mail43-s.fg.online.no") by vger.kernel.org with ESMTP
	id S268961AbUIQTyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 15:54:41 -0400
From: Kenneth =?iso-8859-1?q?Aafl=F8y?= <lists@kenneth.aafloy.net>
To: linux-kernel@vger.kernel.org
Subject: [BUG] Via-Rhine WOL vs PXE Boot
Date: Fri, 17 Sep 2004 21:54:36 +0200
User-Agent: KMail/1.7
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409172154.36550.lists@kenneth.aafloy.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

In recent kernels I have been having trouble booting from a LAN with the built 
in PXE firmware in my Via Epia M10k board. This will never happen after a 
cold-boot. But do accur after the first reboot or power-down/power-up cycle. 
When this occurs the PXE firmware exits with no error, as at least a 
unplugged wire (from cold-boot) will yield an error message with the 
unchanged driver. Cold-boot refers to complete power separation from the 
motherboard.

I've traced this down to a specific change in the via-rhine ethernet driver:

http://linux.bkbits.net:8080/linux-2.6/diffs/drivers/net/via-rhine.c%401.75?nav=index.html|
src/.|src/drivers|src/drivers/net|hist/drivers/net/via-rhine.c

I have not yet tried messing with variations of this change vs the WOL 
feature, or the WOL feature at all, but probably will sometime soon. If 
someone have some idea of what might be going wrong here,
I would be happy to test.

Kenneth
