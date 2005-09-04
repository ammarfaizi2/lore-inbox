Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbVIDFBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbVIDFBJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 01:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbVIDFBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 01:01:09 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:20134 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751119AbVIDFBH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 01:01:07 -0400
Date: Sat, 3 Sep 2005 22:00:26 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Daniel Phillips <phillips@istop.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-cluster@redhat.com,
       wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Message-ID: <20050904050026.GU8684@ca-server1.us.oracle.com>
Mail-Followup-To: Daniel Phillips <phillips@istop.com>,
	Andrew Morton <akpm@osdl.org>, linux-cluster@redhat.com,
	wim.coekaerts@oracle.com, linux-fsdevel@vger.kernel.org, ak@suse.de,
	linux-kernel@vger.kernel.org
References: <20050901104620.GA22482@redhat.com> <200509040022.37102.phillips@istop.com> <20050904043000.GQ8684@ca-server1.us.oracle.com> <200509040051.11095.phillips@istop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200509040051.11095.phillips@istop.com>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2005 at 12:51:10AM -0400, Daniel Phillips wrote:
> Clearly, I ought to have asked why dlmfs can't be done by configfs.  It is the 
> same paradigm: drive the kernel logic from user-initiated vfs methods.  You 
> already have nearly all the right methods in nearly all the right places.

	configfs, like sysfs, does not support ->open() or ->release()
callbacks.  And it shouldn't.  The point is to hide the complexity and
make it easier to plug into.  
	A client object should not ever have to know or care that it is
being controlled by a filesystem.  It only knows that it has a tree of
items with attributes that can be set or shown.

Joel


-- 

"In a crisis, don't hide behind anything or anybody. They're going
 to find you anyway."
	- Paul "Bear" Bryant

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127

