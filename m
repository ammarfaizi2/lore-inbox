Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWAQJFL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWAQJFL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 04:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWAQJFL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 04:05:11 -0500
Received: from ik55118.ikexpress.com ([213.246.55.118]:53140 "EHLO
	ik55118.ikexpress.com") by vger.kernel.org with ESMTP
	id S932360AbWAQJFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 04:05:09 -0500
Message-ID: <43CCB309.4080609@free-electrons.com>
Date: Tue, 17 Jan 2006 10:04:09 +0100
From: Michael Opdenacker <michael-lists@free-electrons.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ketchup] Patch for 'ketchup -l'
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For people managing kernel sources with the excellent 'ketchup' tool (http://www.selenic.com/ketchup/wiki/index.cgi/FrontPage)

Patch for ketchup 0.9.6
=======================

>From Michael Opdenacker <michael@free-electrons.com>

Issue
-----

> ketchup -l
2.4 (signed)
 old stable kernel series
2.4-pre (signed)
 old stable kernel series prereleases
2.6 (signed)
 current stable kernel series
2.6-bk (signed)
 old stable kernel series snapshots
Traceback (most recent call last):
  File "/data/soft/src/ketchup", line 686, in ?
    lprint(tree, ["(unsigned)","(signed)"][version_info[tree][3]])
TypeError: list indices must be integers

Explanation
-----------

For tree '2.6-ck', version_info[tree][3]=='.sig'
instead of '0' or '1'.

The below code only supported the '0' and '1' cases:

lprint(tree, ["(unsigned)","(signed)"][version_info[tree][3]]) 

Fix
---

http://free-electrons.com/pub/patches/ketchup/20060112a/ketchup-l-fix.patch

-- 
Michael Opdenacker, Free Electrons
Free Embedded Linux Training Materials
on http://free-electrons.com/training

