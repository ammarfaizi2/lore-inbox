Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbVK0VXm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbVK0VXm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 16:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751153AbVK0VXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 16:23:42 -0500
Received: from hera.cwi.nl ([192.16.191.8]:44474 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1751092AbVK0VXm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 16:23:42 -0500
Date: Sun, 27 Nov 2005 22:23:40 +0100 (MET)
From: <Andries.Brouwer@cwi.nl>
Message-Id: <200511272123.jARLNeA03057@apps.cwi.nl>
To: linux-kernel@vger.kernel.org
Subject: s_maxbytes on isofs for 2.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a problem report on the handling of large (2.4GB) files
with isofs, where 2.6 was fine and 2.4 failed. Replied

>I suspect that the difference between 2.4 and 2.6 is the assignment
>       s->s_maxbytes = 0xffffffff;
>in isofs/inode.c. Could you try to add that after
>       s->s_magic = ISOFS_SUPER_MAGIC;
>in the 2.4 source?

and got the confirmation that that solves the problems.
Maybe one should consider adding this in 2.4.
No, I have not audited the source. If in fact there is
a reason why files this size are not handled correctly,
there should probably be an assignment with the largest
value that is handled correctly, together with a comment.

Andries

