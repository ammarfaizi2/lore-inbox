Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268799AbUHLVKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268799AbUHLVKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268796AbUHLVJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:09:40 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:15305 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268800AbUHLVGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:06:44 -0400
Subject: Re: New concept of ext3 disk checks
From: Lee Revell <rlrevell@joe-job.com>
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <E1BvKmO-0002dn-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1BvKmO-0002dn-00@calista.eckenfels.6bone.ka-ip.net>
Content-Type: text/plain
Message-Id: <1092344835.1090.74.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 12 Aug 2004 17:07:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-12 at 14:58, Bernd Eckenfels wrote:

> I am not sure why the softupdates are so reliable, that no fsck is needed

Softupdates were introduced to enhance performance by batching and
deferring disk operations.  I belive that initially, performance was the
only consideration in determining what actually got written to disk
when.  All the BSD/OS manuals I read at my last job warn against
enabling softupdates because data loss could occur.

Someone later realized that if you batch the disk operations in a way
that considers the atomicity of the filesystem operations being
implemented, softupdates can help *ensure* data integrity.  This is a
pretty recent development I think.

Lee

