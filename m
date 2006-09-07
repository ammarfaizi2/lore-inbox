Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751662AbWIGLLH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751662AbWIGLLH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 07:11:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWIGLLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 07:11:07 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:38919 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1751662AbWIGLLE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 07:11:04 -0400
Date: Thu, 7 Sep 2006 13:10:59 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: sct@redhat.com, akpm@osdl.org, adilger@clusterfs.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.6.18-rc6] ext3 memory leak
Message-ID: <Pine.LNX.4.63.0609071300330.1700@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this looks like a serious problem to be fixed before 2.6.18 final and 
backported to 2.6.17.*. Or a case of me misunderstanding something, in 
which case, please, let me know.

I've reported before in thread "[2.6.17.4] slabinfo.buffer_head increases" 
a memory leak in ext3. Today I verified it is still present in 2.6.18-rc6.

A short description: as long as write accesses are made on an ext3 
filesystem /proc/slabinfo buffer_head increases unboundedly. This 
behaviour is not observed with another journalling filesystems (e.g., 
reiserfs), or if ext3 is mounted as ext2.

As it seems serious enough to me I'm sending it to ext3 maintainers.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
