Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVEKOaP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVEKOaP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 10:30:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVEKOaO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 10:30:14 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:992 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261234AbVEKO36
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 10:29:58 -0400
Message-ID: <428216DF.8070205@de.ibm.com>
Date: Wed, 11 May 2005 16:29:51 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: cotte@freenet.de
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
CC: schwidefsky@de.ibm.com, akpm@osdl.org
Subject: [RFC/PATCH 0/5] add execute in place support
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folks,

this is the intro to a small series of patches that introduce execute
in place into the I/O stack. File I/O to memory-backed block
devices is performed directly, bypassing the page cache and io
schedulers. On s390, we use this for block devices based on shared
memory between multiple virtual machines. This is also useful on
embedded systems where the block device is located on a flash chip.
This work is a result of a prior discussion with Andrew Morton
about my first implementation which basically was a filesystem
derived from ext2.

As I'd like to aim for integration into -mm and vanilla later on,
I'd like to encourage everyone to give it a read and provide
feedback. All patches apply against git-head as of today.

cheers,
Carsten

