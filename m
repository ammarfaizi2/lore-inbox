Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312931AbSDKHcH>; Thu, 11 Apr 2002 03:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313075AbSDKHcG>; Thu, 11 Apr 2002 03:32:06 -0400
Received: from p-nya.swiftel.com.au ([202.154.76.83]:51462 "EHLO
	mail.robres.com.au") by vger.kernel.org with ESMTP
	id <S312931AbSDKHcG>; Thu, 11 Apr 2002 03:32:06 -0400
Subject: 2.4.18 scsi tape wait for completion
From: Franco Broi <franco@robres.com.au>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 11 Apr 2002 15:31:18 -0400
Message-Id: <1018553478.13516.14.camel@ipcus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I try to offline a tape the tape ejects but the mt command hangs,
if I then reload the tape the mt command completes.

I see in st.c/do_load_unload that the st_do_scsi command has the do_wait
argument set to TRUE, is this correct?  I fixed my problem bu setting it
to FALSE.


