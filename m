Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161354AbWALWIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161354AbWALWIQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161356AbWALWIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:08:15 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51625 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161354AbWALWIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:08:10 -0500
Date: Thu, 12 Jan 2006 14:07:13 -0800
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: torvalds@osdl.org, airlied@linux.ie, linux-kernel@vger.kernel.org,
       len.brown@intel.com, axboe@suse.de, sfrench@us.ibm.com,
       rolandd@cisco.com, wim@iguana.be, aia21@cantab.net,
       linux@dominikbrodowski.net
Subject: Re: git status (was: drm tree for 2.6.16-rc1)
Message-Id: <20060112140713.770be59c.akpm@osdl.org>
In-Reply-To: <1137102945.3621.1.camel@pmac.infradead.org>
References: <Pine.LNX.4.58.0601120948270.1552@skynet>
	<Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
	<20060112134255.29074831.akpm@osdl.org>
	<1137102945.3621.1.camel@pmac.infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Woodhouse <dwmw2@infradead.org> wrote:
>
> On Thu, 2006-01-12 at 13:42 -0800, Andrew Morton wrote:
> > audit: we're tracking one oops which seems to be coming out of the
> > audit code
> 
> Are we? I recall one oops which was tracked down to an inode which had
> i_sb == 0x00000008 so it didn't seem to be audit-related. Was there
> something else I should be looking at?
> 

Well it's oopsing in the audit code, and might not oops without audit. 
Perhaps the audit code is being called before i_sb is fully set up or
something.  We won't know until we know.

Did we work out why i_sb is crazy?
