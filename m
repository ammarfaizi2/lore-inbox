Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266691AbUGVD1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUGVD1u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 23:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266686AbUGVD1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 23:27:50 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:3040 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266691AbUGVD1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 23:27:49 -0400
Subject: Re: reserve legacy io regions on powermac
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: olh@suse.de, benh@kernel.crashing.org, geert@linux-m68k.org
Content-Type: text/plain
Organization: 
Message-Id: <1090457945.1231.711.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 21 Jul 2004 20:59:06 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think a great many drivers could be cleaned up
by making IO fail if the proper IO address cookies
haven't been obtained. This might be done with
byteswapping, XOR, addition, putting a checksum in
the top 2 bytes of a 64-bit cookie, or simply
tracking where an ioremap has been done. Then the
read and write operations can check this.

In general, make IO fail if a driver doesn't play
by the rules.

Perhaps some of the low memory-mapped stuff on
x86 could be moved.


