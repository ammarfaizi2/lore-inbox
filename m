Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262457AbVD2IJg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbVD2IJg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 04:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbVD2IJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 04:09:36 -0400
Received: from smtp.istop.com ([66.11.167.126]:64717 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262457AbVD2IJb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 04:09:31 -0400
From: Daniel Phillips <phillips@istop.com>
To: Joel Becker <Joel.Becker@oracle.com>
Subject: Re: [PATCH 1a/7] dlm: core locking
Date: Fri, 29 Apr 2005 04:10:12 -0400
User-Agent: KMail/1.7
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       David Teigland <teigland@redhat.com>,
       Mark Fasheh <mark.fasheh@oracle.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <20050425165705.GA11938@redhat.com> <1114696137.1920.32.camel@sisko.sctweedie.blueyonder.co.uk> <20050428171915.GE4747@ca-server1.us.oracle.com>
In-Reply-To: <20050428171915.GE4747@ca-server1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504290410.13271.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 April 2005 13:19, Joel Becker wrote:
> On Thu, Apr 28, 2005 at 02:48:57PM +0100, Stephen C. Tweedie wrote:
> > reduce the latency for this case.  My gut feeling, though, is that I'd
> > still prefer to see the DLM doing its work properly, cluster-wide in
> > this case, as precaution against accidents if we get inconsistent states
> > on disk leading to two nodes trying to create the same lock at once.
> > Experience suggests that such things *do* go wrong, and it's as well to
> > plan for them --- early detection is good!
>
>  And unacceptably slow.  With LKM_LOCAL, OCFS2 approaches ext3
> speed untarring a kernel tree, because everything under the toplevel
> directory is a candidate for LKM_LOCAL.  Network communication may be
> fast, but pagecache operations are even faster.  I don't know by how
> much, but I bet if we turned off LKM_LOCAL in the OCFS2 DLM, we'd lose a
> lot of speed.

Why don't you try it, and post the numbers?

Regards,

Daniel
