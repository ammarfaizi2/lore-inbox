Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267994AbUIJW75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267994AbUIJW75 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 18:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267968AbUIJW6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 18:58:20 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:6821 "EHLO
	smtp-out2.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S267994AbUIJWzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 18:55:31 -0400
Message-ID: <414230E1.7090205@blueyonder.co.uk>
Date: Fri, 10 Sep 2004 23:55:29 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
CC: Lee Revell <rlrevell@joe-job.com>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: linux-2.6.9-rc1-bk16 Still cdrom/DVD oops ** FIXED **
References: <4140F3A7.8040103@blueyonder.co.uk>	 <1094776333.1396.31.camel@krustophenia.net>	 <4140FC70.1070101@blueyonder.co.uk> <1094810774.15407.9.camel@krustophenia.net> <41419DB9.4010201@blueyonder.co.uk>
In-Reply-To: <41419DB9.4010201@blueyonder.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Sep 2004 22:55:55.0099 (UTC) FILETIME=[54212AB0:01C49789]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks to Hugh Dickins, I applied Andrew's patch for "rock.c" "RE: 
[2.6.9-rc1-bk14 Oops] In groups_search()" on 2.6.9-rc1-bk17 and I now 
can access CD/DVD. I've been experiencing this problem since 2.6.8.1.
--- 25/fs/isofs/rock.c~rock-kludge 2004-09-10 00:52:30.394468656 -0700
+++ 25-akpm/fs/isofs/rock.c 2004-09-10 00:53:14.544756792 -0700
@@ -62,7 +62,7 @@
}

#define MAYBE_CONTINUE(LABEL,DEV) \
- {if (buffer) kfree(buffer); \
+ {if (buffer) { kfree(buffer); buffer = NULL; } \
if (cont_extent){ \
int block, offset, offset1; \
struct buffer_head * pbh; \

Regards
Sid.
-- 

Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

