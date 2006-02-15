Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751092AbWBOKjN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751092AbWBOKjN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 05:39:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWBOKjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 05:39:13 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:3998 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751092AbWBOKjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 05:39:12 -0500
Date: Wed, 15 Feb 2006 10:39:11 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] fix handling of st_nlink on procfs root
Message-ID: <20060215103911.GL27946@ftp.linux.org.uk>
References: <E1F6vyO-00009r-3a@ZenIV.linux.org.uk> <m1slql3rn2.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1slql3rn2.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2006 at 02:20:17AM -0700, Eric W. Biederman wrote:
> And it is actually wrong.  It fails to take into account the static
> /proc entries.
> > +	stat->nlink = proc_root.nlink + nr_processes();

The hell it does. See ^^^^^^^^^^^^^^ this.
