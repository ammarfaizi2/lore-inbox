Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967870AbWLEAKT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967870AbWLEAKT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 19:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967871AbWLEAKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 19:10:19 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:23187 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967870AbWLEAKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 19:10:17 -0500
Date: Mon, 4 Dec 2006 16:10:07 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Steven Whitehouse <steve@chygwyn.com>
Cc: Valerie Henson <val_henson@linux.intel.com>, linux-kernel@vger.kernel.org,
       ocfs2-devel@oss.oracle.com
Subject: Re: What's in ocfs2.git
Message-ID: <20061205001007.GF19617@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <20061203203149.GC19617@ca-server1.us.oracle.com> <1165229693.3752.629.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1165229693.3752.629.camel@quoit.chygwyn.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Mon, Dec 04, 2006 at 10:54:53AM +0000, Steven Whitehouse wrote:
> > In the future, I'd like to see a "relative atime" mode, which functions
> > in the manner described by Valerie Henson at:
> > 
> > http://lkml.org/lkml/2006/8/25/380
> > 
> I'd like to second that. [adding Val Henson to the "to"] What (if
> anything) remains to be done before the relative atime patch is ready to
> go upstream? I'm happy to help out here if required,
Last time I looked at them, things seemed to be in pretty good shape - it
wasn't a very large patch series.

The thing is (I'm going from memory here), gfs2 and ocfs2 are likely to just
make use of the option parsing (and setting of the MNT_RELATIME flag), and
ignore the changes to touch_atime() since we we handle our own atime
updates.

Overall I think it's a matter of pushing the patches to the kernel and to
mount(8). For ocfs2/gfs2 we implement a small amount of the logic in our
"lock and update atime" functions.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
