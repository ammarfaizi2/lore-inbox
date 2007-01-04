Return-Path: <linux-kernel-owner+w=401wt.eu-S1030194AbXADTOz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbXADTOz (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 14:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030193AbXADTOy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 14:14:54 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:38423 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030194AbXADTOy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 14:14:54 -0500
Date: Thu, 4 Jan 2007 19:14:51 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Eric Sandeen <sandeen@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops return values
Message-ID: <20070104191451.GW17561@ftp.linux.org.uk>
References: <459C4038.6020902@redhat.com> <20070103162643.5c479836.akpm@osdl.org> <459D3E8E.7000405@redhat.com> <20070104102659.8c61d510.akpm@osdl.org> <459D4897.4020408@redhat.com> <20070104105430.1de994a7.akpm@osdl.org> <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 04, 2007 at 11:09:31AM -0800, Linus Torvalds wrote:
 
> But I'd argue we should only do it if there is an actual 
> honest-to-goodness reason to do so.

How about "makes call graph analysis easier"? ;-)  In principle, I have
no problem with force-casting, but it'd better be cast to the right
type...

(And yes, there's a bunch of sparse-based fun in making dealing with
call graph analysis and sane annotations needed for that).
