Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262037AbUCDRTK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 12:19:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262038AbUCDRTJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 12:19:09 -0500
Received: from 18-165-237-24-mvl.nwc.gci.net ([24.237.165.18]:60341 "EHLO
	nevaeh-linux.org") by vger.kernel.org with ESMTP id S262037AbUCDRTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 12:19:04 -0500
Date: Thu, 4 Mar 2004 08:19:04 -0900 (AKST)
From: Arthur Corliss <corliss@digitalmages.com>
X-X-Sender: acorliss@bifrost.nevaeh-linux.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BSD process accounting with high uids
Message-ID: <Pine.LNX.4.58.0403040808550.17819@bifrost.nevaeh-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings:

Looking at the archives I see that this has been brought up in the past a few
times, but no one ever replied or resolved the issue (unless I missed
something).

Problem:  UIDs recorded are typed smaller than the 2.4+ default uid_t size.

Solution:  A two line patch in include/linux/acct.h which casts ac_uid &
ac_gid as uid_t/gid_t instead of __u16.

Now, I have to ask, why hasn't this been done already?  If I submit a patch,
will anyone consider actually applying this?  Or will I have to continue to
munge that file myself (and glibc's sys/acct.h) in order to get my tools to
work they're supposed to?

The sources for kernel 2.6.3 also still list uid/gid fields as __u16, BTW.

	--Arthur Corliss
	  Bolverk's Lair -- http://arthur.corlissfamily.org/
	  Digital Mages -- http://www.digitalmages.com/
	  "Live Free or Die, the Only Way to Live" -- NH State Motto
