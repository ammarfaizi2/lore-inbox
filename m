Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263023AbVAFUSN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263023AbVAFUSN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 15:18:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263025AbVAFUQo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 15:16:44 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:21176 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263020AbVAFUNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 15:13:25 -0500
Date: Thu, 6 Jan 2005 12:13:11 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jtk@us.ibm.com,
       wtaber@us.ibm.com, pbadari@us.ibm.com, markv@us.ibm.com,
       greghk@us.ibm.com
Subject: Re: [PATCH] fs: Restore files_lock and set_fs_root exports
Message-ID: <20050106201311.GI1292@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050106190538.GB1618@us.ibm.com> <20050106191441.GM26051@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050106191441.GM26051@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2005 at 07:14:41PM +0000, Al Viro wrote:
> On Thu, Jan 06, 2005 at 11:05:38AM -0800, Paul E. McKenney wrote:
> > Hello, Andrew,
> > 
> > Some export-removal work causes breakage for an out-of-tree filesystem.
> > Could you please apply the attached patch to restore the exports for
> > files_lock and set_fs_root?
> 
> What, in name of everything unholy, is *filesystem* doing with set_fs_root()?

It is using it to set the process's view of the source-code control
system to the desired version.  So process A can see version 2.1 while
process B sees version 1.5, and so that either process can change the
version that it sees on the fly.

						Thanx, Paul
