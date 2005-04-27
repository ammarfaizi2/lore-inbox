Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261944AbVD0Smy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261944AbVD0Smy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 14:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbVD0SlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 14:41:15 -0400
Received: from ccerelbas04.cce.hp.com ([161.114.21.107]:650 "EHLO
	ccerelbas04.cce.hp.com") by vger.kernel.org with ESMTP
	id S261944AbVD0Sj7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 14:39:59 -0400
Date: Wed, 27 Apr 2005 13:40:22 -0500
From: mike.miller@hp.com
To: linux-kernel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org, brace@hp.com
Subject: [Question] Does the kernel ignore errors writng to disk?
Message-ID: <20050427184022.GA16129@beardog.cca.cpqcorp.net>
Reply-To: mike.miller@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,
I have observed some behavior under certain failure conditions that seems as if the kernel may be ignoring write errors to disk. 
During very heavy read/write io if we force a disk to fail requests continue to be submitted until the controllers queue is full. Ultimately, the requests are timed out by the controller. When this happens we see filesystem corruption. Sometimes it's the file data, other times it's filesystem metadata that has been timed out and failed. Either way its obviously undesirable behavior.
It looks like the OS/filesystem (ext2/3 and reiserfs) does not wait for for a successful completion. Is this assumption correct?

Thanks,
mikem
