Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWCIVEt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWCIVEt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 16:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751519AbWCIVEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 16:04:49 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:14037 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750901AbWCIVEs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 16:04:48 -0500
Date: Thu, 9 Mar 2006 21:04:45 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Kirill Korotaev <dev@openvz.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ext3: ext3_symlink should use GFP_NOFS allocations inside
Message-ID: <20060309210445.GU27946@ftp.linux.org.uk>
References: <44106393.2050207@openvz.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44106393.2050207@openvz.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2006 at 08:19:15PM +0300, Kirill Korotaev wrote:
> This patch fixes illegal __GFP_FS allocation inside ext3
> transaction in ext3_symlink().
> Such allocation may re-enter ext3 code from
> try_to_free_pages. But JBD/ext3 code keeps a pointer to current
> journal handle in task_struct and, hence, is not reentrable.
 
New helper, please.
