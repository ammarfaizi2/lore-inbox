Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266267AbUG0FcH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266267AbUG0FcH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 01:32:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266246AbUG0FcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 01:32:07 -0400
Received: from fw.osdl.org ([65.172.181.6]:3764 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266267AbUG0FcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 01:32:05 -0400
Date: Mon, 26 Jul 2004 22:30:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ravikiran G Thirumalai <kiran@in.ibm.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk, dipankar@in.ibm.com
Subject: Re: [patch] Use kref for struct file.f_count refcounter
Message-Id: <20040726223036.281106c5.akpm@osdl.org>
In-Reply-To: <20040726150312.GJ1231@obelix.in.ibm.com>
References: <20040726150312.GJ1231@obelix.in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ravikiran G Thirumalai <kiran@in.ibm.com> wrote:
>
> This patch makes use of the kref api for the 
>  struct file.f_count refcounter.  This depends
>  on the new kref apis kref_read and kref_put_last
>  added by means of my earlier patch today.

Sorry, but I can't really see how this improves anything.  It'll slow
things down infinitesimally and it forces the reader to look elsewhere in
the tree to see what's going on.

