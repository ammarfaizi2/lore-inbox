Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753943AbWKGBrK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753943AbWKGBrK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 20:47:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753944AbWKGBrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 20:47:09 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:31309 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1753943AbWKGBrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 20:47:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:mime-version:content-type:content-transfer-encoding:x-mailer:thread-index:x-mimeole:message-id;
        b=K8TfmCSrUSLNY/HPi3XlguXrWvtSpzsFfWl6haU7KX/8P2DKfgTY8IOLsCZdJQ6pYogHiuqB4iHzWaLe8xUnmSmquFaBjCvHMZWWATQGzwWoYWRPMMNJ6adXD2CXi2B8xK4XGmMQZlB46Aaqt9PnMv70SnUyii+ERwZKRZcYEv8=
From: "Bin Chen" <binary.chen@gmail.com>
To: <linux-kernel@vger.kernel.org>
Subject: UNIX domain socket problem
Date: Tue, 7 Nov 2006 09:47:02 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AccCDp78Q+1phDq+TvuNzHd2Ov8jFw==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Message-ID: <454fe59b.6455ade0.6506.1f45@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for cross post, it has been posted on
comp.os.linux.development.apps.

I wrote a domain socket sever, which is a STREAM type, let it listen a
sun_path, and in a while loop it accept new connections. I analyze it
using netstat.

Abstractly, the communication need two end. Even the listen socket is
only one, each time the accept returns, there should be two end
produced: one by connect() issued by client, one by accept() issued by
server. These two should have different inode number.

What is strange is that I sometimes find the RefCnt of some unix domain
socket have values 2,3,4,5,6,7 or even 258, if each connection in
stream should be in pair, why this problem occurs?

Thanks.
Binary

