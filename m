Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTHWBdH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 21:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbTHWBdG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 21:33:06 -0400
Received: from remt26.cluster1.charter.net ([209.225.8.36]:28665 "EHLO
	remt26.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264353AbTHWBc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 21:32:56 -0400
Subject: cramfs crc?
From: Josh Boyer <jwboyer@charter.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1061602374.2003.15.camel@yoda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Aug 2003 20:32:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the cramfs_info structure contains a u32 crc field, but it is never used
in the kernel.  the mkcramfs tool calculates a crc on the whole fs image
and then embeddeds this crc into the image file.

why is this never checked in the kernel?  it could be recalculated at
mount time and compared the the embedded crc.  if a mismatch is
detected, the mount could simply fail.

is there a reason this isn't done, or is it that nobody thought it would
be useful?


thx,
jb

