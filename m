Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbUCNW1N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 17:27:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUCNW1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 17:27:13 -0500
Received: from mxfep01.bredband.com ([195.54.107.70]:16313 "EHLO
	mxfep01.bredband.com") by vger.kernel.org with ESMTP
	id S261978AbUCNW1J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 17:27:09 -0500
To: linux-kernel@vger.kernel.org
Subject: kernel threads holding /dev/console
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: Sun, 14 Mar 2004 23:27:07 +0100
Message-ID: <yw1x8yi3dpz8.fsf@ford.guide>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm trying to set up a pivot_root hack to do some things, switch root,
and then unmount the original root.  However, the unmount fails
because ksoftirqd/0, events/0, kblockd/0 and aio/0 have /dev/console
opened.  Why are they doing this?  Can it be prevented?  This happens
when using kernel 2.6.3 (2.6.4 is reportedly broken on Alpha).  It
works with a 2.4 kernel using the same script.  Does anyone have a
hint?

-- 
Måns Rullgård
mru@kth.se
