Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261335AbULIOF3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261335AbULIOF3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261322AbULIOF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:05:29 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:15328 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S261335AbULIOFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:05:17 -0500
Date: Thu, 9 Dec 2004 08:05:04 -0600
From: Robin Holt <holt@sgi.com>
To: Limin Gu <limin@dbear.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] jobfs - new virtual filesystem for job kernel/user interface
Message-ID: <20041209140504.GD5187@lnx-holt.americas.sgi.com>
References: <200412082203.iB8M3Lk22375@dbear.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200412082203.iB8M3Lk22375@dbear.engr.sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 02:03:21PM -0800, Limin Gu wrote:
> Hello,
> 
> I am looking for your comments on the attached draft, it is the job patch 
> for 2.6.9. I have posted job patch for older kernel before, but in this patch
> I have replaced the /proc/job binary ioctl calls with a new small virtual 
> filesystem (jobfs).
> 
> Job uses the hook provided by PAGG (Process Aggregates). A job is a group
> related processes all descended from a point of entry process and identified
> by a unique job identifier (jid). You can find the general information
> about PAGG and Job at http://oss.sgi.com/projects/pagg/
> 
> I will very much appreciate your comments, suggestions and criticisms
> on this new filesystem design and implementation as the job kernel/user
> communication interface. The patch is still a draft.
> 
> Thank you!

I maintain my position that this belongs in /proc.

Why not have a structure something like:

/proc/<pid>/job -> ../jobs/<jid>
/proc/jobs/<jid>/<pid> -> ../../<pid>

What other information is really necessary from userland?

Robin
