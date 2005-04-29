Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262980AbVD2VxG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262980AbVD2VxG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262991AbVD2VxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:53:06 -0400
Received: from rgminet04.oracle.com ([148.87.122.33]:384 "EHLO
	rgminet04.oracle.com") by vger.kernel.org with ESMTP
	id S262980AbVD2Vw7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:52:59 -0400
Date: Fri, 29 Apr 2005 14:52:21 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Daniel Phillips <phillips@istop.com>
Cc: Joel Becker <Joel.Becker@oracle.com>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       David Teigland <teigland@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1a/7] dlm: core locking
Message-ID: <20050429215221.GC355@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050425165705.GA11938@redhat.com> <1114696137.1920.32.camel@sisko.sctweedie.blueyonder.co.uk> <20050428171915.GE4747@ca-server1.us.oracle.com> <200504290410.13271.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504290410.13271.phillips@istop.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 04:10:12AM -0400, Daniel Phillips wrote:
> Why don't you try it, and post the numbers?

*Sigh*

Done from a test machine I have over here on a two node cluster. 
I rebooted and re-formatted between tests.

* Without LKM_LOCAL:
[root@ca-test7 ocfs2]# time tar -zxf /tmp/linux-2.6.11.7.tar.gz 

real    0m39.699s
user    0m3.644s
sys     0m8.076s


* With LKM_LOCAL
[root@ca-test7 ocfs2]# time tar -zxf /tmp/linux-2.6.11.7.tar.gz 

real    0m22.076s
user    0m3.869s
sys     0m7.234s

So yes, I'd say it's worth a significant amount of performance to us :)
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com

