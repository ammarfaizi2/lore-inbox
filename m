Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271106AbTHLUpm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 16:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271107AbTHLUpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 16:45:42 -0400
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:34761
	"EHLO bastard") by vger.kernel.org with ESMTP id S271106AbTHLUpl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 16:45:41 -0400
Message-ID: <3F3951F1.9040605@tupshin.com>
Date: Tue, 12 Aug 2003 13:45:37 -0700
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5b) Gecko/20030723 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: data corruption using raid0+lvm2+jfs with 2.6.0-test3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an LVM2 setup with four lvm groups. One of those groups sits on 
top of a two disk raid 0 array. When writing to JFS partitions on that 
lvm group, I get frequent, reproducible data corruption. This same setup 
works fine with 2.4.22-pre kernels. The JFS may or may not be relevant, 
since I haven't had a chance to use other filesystems as a control. 
There are a number of instances of the following message associated with 
the data corruption:

raid0_make_request bug: can't convert block across chunks or bigger than 
8k 12436792 8

The 12436792 varies widely, the rest is always the same. The error is 
coming from drivers/md/raid0.c.

-Tupshin

