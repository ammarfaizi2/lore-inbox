Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267234AbUBSNMY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267249AbUBSNMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:12:24 -0500
Received: from hazard.jcu.cz ([160.217.1.6]:4224 "EHLO hazard.jcu.cz")
	by vger.kernel.org with ESMTP id S267234AbUBSNMX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:12:23 -0500
Date: Thu, 19 Feb 2004 14:12:21 +0100
From: Jan Marek <linux@hazard.jcu.cz>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.3-mm1][PROBLEM] Apache cannot start
Message-ID: <20040219131221.GA1328@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo lkml,

I have problem with kernel 2.6.3-mm1: apache cannot start. Some last
lines from strace output:

3299  shmget(IPC_PRIVATE, 737284, IPC_CREAT|0600) = 393216
3299  shmat(393216, 0, 0)               = -1 EINVAL (Invalid argument)
3299  time(NULL)                        = 1077193406
3299  write(15, "[Thu Feb 19 13:23:26 2004] [emer"..., 69) = 69
3299  shmctl(393216, IPC_64|IPC_RMID, 0) = 0
3299  munmap(0x40018000, 4096)          = 0
3299  exit_group(2)                     = ?

I think, that problem is in the calling shmat function?

My last kernel was 2.6.2-mm1 and here apache went without problems...

Sincerely
Jan Marek
-- 
Ing. Jan Marek
University of South Bohemia
Academic Computer Centre
Phone: +420-38-7772080
