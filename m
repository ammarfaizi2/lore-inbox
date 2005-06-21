Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262482AbVFUWuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262482AbVFUWuU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVFUWt1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:49:27 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:1716 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262422AbVFUWqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:46:36 -0400
Subject: Re: [RFC] [PATCH] OCFS2
From: Steve French <smfltc@us.ibm.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <20050621220313.GA7531@ca-server1.us.oracle.com>
References: <1119388469.5701.145.camel@stevef95.austin.ibm.com>
	 <20050621220313.GA7531@ca-server1.us.oracle.com>
Content-Type: text/plain
Organization: IBM - Linux Technology Center
Message-Id: <1119393793.5690.170.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 21 Jun 2005 17:43:13 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-21 at 17:03, Mark Fasheh wrote:

> If you see anywhere our supported feature set is actually misstated, please
> let me know so I can correct that immediately.

The list is not wrong. I was just noting that it was too short, missing
three items of particular interest for server filesystems (which seems
to be the target environment). Support for:
	Directory change notification (F_NOTIFY)
	Distributed Caching (F_SETLEASE/F_GETLEASE/break_lease)
	POSIX ACLs
The lack of support for lsattr/chattr (chflags) is less important, and
the lack of support for the multipage operations (writepages and
readpages) is not a compatability issue and is not critical, although it
might hurt performance.

I did see that you have aio - and that was interesting because there are
so few implementations and that as well as vectorio was something I
wanted to explore for the cifs vfs client.

