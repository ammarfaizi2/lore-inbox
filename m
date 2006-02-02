Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWBBQaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWBBQaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 11:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWBBQaG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 11:30:06 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:32894 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932133AbWBBQaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 11:30:04 -0500
Message-ID: <43E233F4.3040903@openvz.org>
Date: Thu, 02 Feb 2006 19:31:48 +0300
From: Kirill Korotaev <dev@openvz.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: Kirill Korotaev <dev@openvz.org>
CC: serue@us.ibm.com, arjan@infradead.org, frankeh@watson.ibm.com,
       clg@fr.ibm.com, haveblue@us.ibm.com, mrmacman_g4@mac.com,
       alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, devel@openvz.org
Subject: [RFC][PATCH 6/7] VPIDs: small proc VPID export
References: <43E22B2D.1040607@openvz.org>
In-Reply-To: <43E22B2D.1040607@openvz.org>
Content-Type: multipart/mixed;
 boundary="------------050708000401080902010101"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050708000401080902010101
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Export of task VPID to /proc
Simple.

Kirill

--------------050708000401080902010101
Content-Type: text/plain;
 name="diff-vpids-proc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff-vpids-proc"

--- ./fs/proc/array.c.vpid_proc	2006-02-02 14:33:58.000000000 +0300
+++ ./fs/proc/array.c	2006-02-02 17:54:34.673273968 +0300
@@ -200,6 +200,8 @@ static inline char * task_state(struct t
 	put_group_info(group_info);
 
 	buffer += sprintf(buffer, "\n");
+
+	buffer += sprintf(buffer, "VPid:\t%d\n", virt_pid(p));
 	return buffer;
 }
 

--------------050708000401080902010101--

