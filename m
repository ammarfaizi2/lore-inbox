Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965248AbVHJSW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965248AbVHJSW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 14:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965249AbVHJSW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 14:22:59 -0400
Received: from rgminet03.oracle.com ([148.87.122.32]:57748 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S965248AbVHJSW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 14:22:58 -0400
Date: Wed, 10 Aug 2005 11:21:56 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Christoph Hellwig <hch@infradead.org>, Zach Brown <zab@zabbo.net>,
       David Teigland <teigland@redhat.com>, Pekka Enberg <penberg@gmail.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Message-ID: <20050810182155.GI21228@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20050802071828.GA11217@redhat.com> <84144f0205080203163cab015c@mail.gmail.com> <20050803063644.GD9812@redhat.com> <courier.42F768D5.000046F2@courier.cs.helsinki.fi> <42F7A557.3000200@zabbo.net> <1123598983.10790.1.camel@haji.ri.fi> <20050810072121.GA2825@infradead.org> <courier.42F9AD38.000018F9@courier.cs.helsinki.fi> <20050810162618.GH21228@ca-server1.us.oracle.com> <courier.42FA3207.00002648@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <courier.42FA3207.00002648@courier.cs.helsinki.fi>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2005 at 07:57:43PM +0300, Pekka J Enberg wrote:
> Surely avoiding them is preferred but how do you do that when you have to 
> mmap'd regions where userspace does memcpy()? The kernel won't much saying 
> in it until ->nopage. We cannot grab all the required locks in proper order 
> here because we don't know what size the buffer is. That's why I think lock 
> sorting won't work of all the cases and thus the problem needs to be taken 
> care of by the dlm. 
Hmm, well today in OCFS2 if you're not coming from read or write, the lock
is held only for the duration of ->nopage so I don't think we could get into
any deadlocks for that usage.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
