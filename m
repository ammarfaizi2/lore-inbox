Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVG0WWJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVG0WWJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 18:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVG0WTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 18:19:39 -0400
Received: from ms-smtp-01-smtplb.rdc-nyc.rr.com ([24.29.109.5]:13003 "EHLO
	ms-smtp-01.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S261188AbVG0WSL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 18:18:11 -0400
Message-ID: <42E807FC.4050508@temple.edu>
Date: Wed, 27 Jul 2005 18:17:32 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: [PATCH 2.6.13-rc3-mm2] fs/reiser4/plugin/node/node40.h fix warning
 with -Wundef
Content-Type: multipart/mixed;
 boundary="------------000303060705080407000103"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000303060705080407000103
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fixes another -Wundef warning in ReiserFS code.


Nick Sillik
n.sillik@temple.edu

Signed-off-by: Nick Sillik <n.sillik@temple.edu>

--------------000303060705080407000103
Content-Type: text/plain;
 name="reiser_node40_wundef.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="reiser_node40_wundef.patch"

diff -urN a/fs/reiser4/plugin/node/node40.h b/fs/reiser4/plugin/node/node40.h
--- a/fs/reiser4/plugin/node/node40.h	2005-07-27 18:14:04.000000000 -0400
+++ b/fs/reiser4/plugin/node/node40.h	2005-07-27 18:14:53.000000000 -0400
@@ -80,7 +80,7 @@
 int check_node40(const znode * node, __u32 flags, const char **error);
 int parse_node40(znode * node);
 int init_node40(znode * node);
-#if GUESS_EXISTS
+#ifdef GUESS_EXISTS
 int guess_node40(const znode * node);
 #endif
 void change_item_size_node40(coord_t * coord, int by);

--------------000303060705080407000103--
