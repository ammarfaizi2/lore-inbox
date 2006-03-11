Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752278AbWCKAo1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbWCKAo1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 19:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752279AbWCKAo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 19:44:27 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:61380 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1752273AbWCKAo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 19:44:26 -0500
Message-ID: <44121D65.5010004@oracle.com>
Date: Fri, 10 Mar 2006 16:44:21 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Phillips <phillips@google.com>
CC: linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Another ocfs2 performance bug
References: <4411FE80.7030302@google.com>
In-Reply-To: <4411FE80.7030302@google.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Reading all the files in a big directory tree takes at least four times
> as long on ocfs2 as ext3.

> real   1m54.933s  <===

> real    0m23.899s <===

Can you doctor your scripts to show at least some overview of the IO
patterns?  Just the amount of reads and writes would be a good start,
but something like graphing blktrace output would be wildly instructive.

My first guess would be the known difference between OCFS2's full-block
inodes and ext3's habit of packing lots of inode structs into a block.

Secondary guesses would be lack of directory read-ahead, bad IO patterns
based on allocation policy, etc..

- z
