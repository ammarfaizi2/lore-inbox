Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314226AbSDRClQ>; Wed, 17 Apr 2002 22:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314227AbSDRClP>; Wed, 17 Apr 2002 22:41:15 -0400
Received: from redback.disy.cse.unsw.EDU.AU ([129.94.239.39]:42628 "EHLO
	redback.cse.unsw.edu.au") by vger.kernel.org with ESMTP
	id <S314226AbSDRClP>; Wed, 17 Apr 2002 22:41:15 -0400
To: linux-kernel@vger.kernel.org
Subject: A question about ll_10byte_cmd_build
From: peterc@gelato.unsw.edu.au
Message-Id: <E16y1rE-0001Zf-00@redback.cse.unsw.edu.au>
Date: Thu, 18 Apr 2002 12:41:12 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



(Linux 2.5.8)
In ll_rw_blk.c there's a function, ll_10byte_cmd_build() which is
supposed to be used to generate `10-byte commands'.

It appears to generate a SCSI READ_10 or WRITE_10 command (which
happen to be identical in format to the ATAPI GPCMD_{READ,WRITE}_10 commands)

Is this IDE specific, or is it meant to cover all block devices?
If it's IDE specific, why is it in ll_rw_blk.c, which is meant to be
common to all block devices?


As far as I can tell, only ide-cd.c actually uses the function in a
stock 2.5.8 kernel --- so it could theoretically be moved to ide-cd.c.

Peter C
