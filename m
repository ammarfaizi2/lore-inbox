Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932664AbWCJBOc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932664AbWCJBOc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 20:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWCJBOc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 20:14:32 -0500
Received: from smtp.osdl.org ([65.172.181.4]:35025 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932664AbWCJBOa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 20:14:30 -0500
Date: Thu, 9 Mar 2006 17:16:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: sct@redhat.com, jack@suse.cz, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Ext2-devel@lists.sourceforge.net
Subject: Re: [RFC PATCH] ext3 writepage() journal avoidance
Message-Id: <20060309171632.46c11c85.akpm@osdl.org>
In-Reply-To: <4410CC3E.6030905@us.ibm.com>
References: <1141929562.21442.4.camel@dyn9047017100.beaverton.ibm.com>
	<20060309152254.743f4b52.akpm@osdl.org>
	<4410CC3E.6030905@us.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty <pbadari@us.ibm.com> wrote:
>
> >Don't forget that ext3 supports journalled-mode files on ordered- or
> >writeback-mounted filesystems, via `chattr +j'.  
> >
> 
> Wow !! Never knew that. I assume we switch mapping->a_ops for this inode ?

Yes, that's all tucked away in ext3_should_journal_data().
