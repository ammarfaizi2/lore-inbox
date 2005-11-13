Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751352AbVKMFNF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352AbVKMFNF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 00:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbVKMFNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 00:13:05 -0500
Received: from c-67-177-11-17.hsd1.ut.comcast.net ([67.177.11.17]:5248 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1751352AbVKMFNE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 00:13:04 -0500
Message-ID: <4376B787.9000108@soleranetworks.com>
Date: Sat, 12 Nov 2005 20:48:23 -0700
From: "Jeff V. Merkey" <jmerkey@soleranetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Severe VFS Performance Issues 2.6 with > 95000 directory entries
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The subject line speaks for itself.   This is using standard VFS readdir 
and lookup calls through the VFSwith ftp.  Very poor. 
It appears dcache related since longer file names proportionately take 
longer based on the size of the name.  My lookup routines use static 
pinned tables in memory, and are very fast.  VFS peformance non-ftp are 
reasonable, but still have problems with the number of entries
in a directory gets above 50,000.

Jeff
