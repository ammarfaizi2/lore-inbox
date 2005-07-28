Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbVG1U6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbVG1U6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 16:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbVG1U6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 16:58:01 -0400
Received: from ms-smtp-02-smtplb.rdc-nyc.rr.com ([24.29.109.6]:36261 "EHLO
	ms-smtp-02.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id S262201AbVG1U5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 16:57:23 -0400
Message-ID: <42E94679.2020009@temple.edu>
Date: Thu, 28 Jul 2005 16:56:25 -0400
From: Nick Sillik <n.sillik@temple.edu>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Michael Thonke <iogl64nx@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
References: <20050728025840.0596b9cb.akpm@osdl.org>	<42E957B5.8040606@gmail.com> <20050728131525.31fa8640.akpm@osdl.org>
In-Reply-To: <20050728131525.31fa8640.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010307050907010107080700"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010307050907010107080700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> Michael Thonke <iogl64nx@gmail.com> wrote:
> 
>>Hello Andrew,
>>
>>I have some questions :-)
>>Reiser4:
>>
>>why there are undefined functions implemented that currently not in use?
>>This messages appeared first time in 2.6.13-rc3-mm2.
>>
>>Any why it complains even CONFIG_REISER4_DEBUG is not set?
> 
> 
> That's due to the code using `#if CONFIG_xx' instead of `#ifdef'.
> 

I previously posted a patch that got rid of one of these, find it 
attached again below.

Signed-off-by: Nick Sillik <n.sillik@temple.edu>

--------------010307050907010107080700
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

--------------010307050907010107080700--
