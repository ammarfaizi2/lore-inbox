Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTFABjj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 21:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbTFABjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 21:39:39 -0400
Received: from smtp-out.comcast.net ([24.153.64.115]:31583 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261151AbTFABjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 21:39:39 -0400
Date: Sat, 31 May 2003 21:46:03 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: another must-fix: major PS/2 mouse problem
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: akpm@digeo.com
Message-id: <1054431962.22103.744.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lots of people (check Google) get this message
from the kernel:

psmouse.c: Lost synchronization, throwing 2 bytes away.

(the number of bytes will be 1, 2, or 3)

At work, I get it when there is heavy NFS traffic.
The mouse goes crazy, jumping around and doing
random cut-and-paste all over everything. This is
with a decently fast and modern PC.

I'll guess that NFS and the mouse both have worker
threads fighting for CPU time, and neither is RT.



