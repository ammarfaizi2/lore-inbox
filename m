Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262178AbVD1RTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbVD1RTu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 13:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVD1RTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 13:19:50 -0400
Received: from agminet02.oracle.com ([141.146.126.229]:4217 "EHLO
	agminet02.oracle.com") by vger.kernel.org with ESMTP
	id S262178AbVD1RTr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 13:19:47 -0400
Date: Thu, 28 Apr 2005 10:19:15 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: David Teigland <teigland@redhat.com>, Mark Fasheh <mark.fasheh@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1a/7] dlm: core locking
Message-ID: <20050428171915.GE4747@ca-server1.us.oracle.com>
Mail-Followup-To: "Stephen C. Tweedie" <sct@redhat.com>,
	David Teigland <teigland@redhat.com>,
	Mark Fasheh <mark.fasheh@oracle.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <20050425165705.GA11938@redhat.com> <20050427214136.GC938@ca-server1.us.oracle.com> <20050428034550.GA10628@redhat.com> <1114696137.1920.32.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1114696137.1920.32.camel@sisko.sctweedie.blueyonder.co.uk>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 02:48:57PM +0100, Stephen C. Tweedie wrote:
> reduce the latency for this case.  My gut feeling, though, is that I'd
> still prefer to see the DLM doing its work properly, cluster-wide in
> this case, as precaution against accidents if we get inconsistent states
> on disk leading to two nodes trying to create the same lock at once. 
> Experience suggests that such things *do* go wrong, and it's as well to
> plan for them --- early detection is good!

	And unacceptably slow.  With LKM_LOCAL, OCFS2 approaches ext3
speed untarring a kernel tree, because everything under the toplevel
directory is a candidate for LKM_LOCAL.  Network communication may be
fast, but pagecache operations are even faster.  I don't know by how
much, but I bet if we turned off LKM_LOCAL in the OCFS2 DLM, we'd lose a
lot of speed.

Joel

-- 

 One look at the From:
 understanding has blossomed
 .procmailrc grows
	- Alexander Viro

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

