Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261166AbUBTLcF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 06:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUBTLcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 06:32:05 -0500
Received: from piro.phys2.uniroma1.it ([151.100.123.25]:58243 "EHLO
	piro.phys2.uniroma1.it") by vger.kernel.org with ESMTP
	id S261166AbUBTLcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 06:32:02 -0500
Subject: laptop mode in 2.4.24
From: Cristiano De Michele <demichel@na.infn.it>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: Department of Physics, University of Naples "Federico II"
Message-Id: <1077276719.6533.16.camel@piro>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 12:32:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I had kernel 2.4.22-ac4 + laptop mode patch 
and it worked perfectly.
Now I'm on a 2.4.24 kernel where the aforementioned
patch has been merged in, but it seems
that it does not work properly,
I've set bdflush as follows:

cat /proc/sys/vm/bdflush
30 500 0 0 60000 60000 60 20 0

cat /proc/sys/vm/laptop_mode
1

and using
echo "1" > cat /proc/sys/vm/block_dump

in syslog there are only such messages:

.
.
.
Feb 20 11:31:17 piro kernel: kjournald: WRITE block 46640/8 on 03:05
Feb 20 11:31:17 piro kernel: kjournald: WRITE block 46648/8 on 03:05
.
.
.

that is only journaling is writing to my HD
and anyway every minute more or less something
gets written to HD preventing it from being spinned down

thx Cristiano

  
-- 
Cristiano De Michele <demichel@na.infn.it>
Department of Physics, University of Naples "Federico II"
