Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264653AbUE2NJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264653AbUE2NJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 May 2004 09:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264719AbUE2NJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 May 2004 09:09:45 -0400
Received: from mxfep02.bredband.com ([195.54.107.73]:57747 "EHLO
	mxfep02.bredband.com") by vger.kernel.org with ESMTP
	id S264653AbUE2NJn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 May 2004 09:09:43 -0400
Subject: 2.6 and sendfile()
From: Alexander Nyberg <alexn@telia.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1085836181.648.10.camel@boxen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 29 May 2004 15:09:42 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6 no longer seems to support copying files via sys_sendfile(), only
files to sockets. It gets stuck at do_sendfile()

if (!out_file->f_op || !out_file->f_op->sendpage)

None of the file systems has a sendpage function, is this intentional?
After googling around I saw this has resulted in some broken programs. 

Was the semantics of sendfile() simply changed and in that case why,
cause it should be a bit of a speed booster to many applications.

Alex

