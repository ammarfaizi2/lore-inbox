Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265805AbUH0Oyl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUH0Oyl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 10:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUH0Oyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 10:54:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1152 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265805AbUH0Oyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 10:54:37 -0400
Date: Fri, 27 Aug 2004 10:50:23 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Roger Luethi <rl@hellgate.ch>
cc: linux-kernel@vger.kernel.org,
       Albert Cahalan <albert@users.sourceforge.net>,
       William Lee Irwin III <wli@holomorphy.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [0/2][ANNOUNCE] nproc: netlink access to /proc information
In-Reply-To: <20040827122412.GA20052@k3.hellgate.ch>
Message-ID: <Xine.LNX.4.44.0408271043130.7393-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Aug 2004, Roger Luethi wrote:

> At the moment, the kernel sends a separate netlink message for every
> process.

You should look at the way rtnetlink dumps large amounts of data to  
userspace.

> I haven't implemented any form of access control. One possibility is
> to use some of the reserved bits in the ID field to indicate access
> restrictions to both kernel and user space (e.g. everyone, process owner,
> root) 

So, user tools would all need to be privileged?  That sounds problematic.

> and add some LSM hook for those needing fine-grained control.

Control over the user request, or what the kernel returns?  If the latter, 
LSM is not really a filtering API.


- James
-- 
James Morris
<jmorris@redhat.com>


