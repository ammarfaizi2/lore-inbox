Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUFHPoz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUFHPoz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUFHPoz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:44:55 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:40675 "EHLO
	thumper2.allantgroup.com") by vger.kernel.org with ESMTP
	id S265230AbUFHPow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:44:52 -0400
Date: Tue, 8 Jun 2004 10:44:22 -0500
From: Andy <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Subject: NFS corruption (duplicated data)
Message-ID: <20040608154422.GA3946@thumper2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I really don't understand what could be causing this, but it happens on
several machine and at least on kernels 2.4.22, 2.4.25, 2.4.26.
NFS v3 : hard, udp, rsize=8192,wsize=8192
local filesystems are XFS

Trond, this is data corruption not dropped packets so the protocol
being UDP is not the problem.

Here is what is happening :

Copying a file of offsets from machine A to machine B over NFS and then
comparing the file on B with the file on A over NFS, the file on machine B
is corrupted in the following ways. 

Usually, data earlier in the file will show up again later.
For example :

57344 bytes of data from 672190464-672247807 is also in positions
1449664512-1449721855

sometimes, data later in the file is dupped to a position before it
should be

53248 bytes of data from 1197158400-1197211647 is also in positions
1036660736-1036713983

Any ideas

Andy
