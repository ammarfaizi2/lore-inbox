Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbTEGKiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTEGKiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:38:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43449 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263062AbTEGKiF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:38:05 -0400
Date: Wed, 7 May 2003 11:50:38 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>, Jan Harkes <jaharkes@cs.cmu.edu>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Process Attribute API for Security Modules 2.5.69
Message-ID: <20030507105038.GN10374@parcelfarce.linux.theplanet.co.uk>
References: <1052237601.1377.991.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052237601.1377.991.camel@moss-huskers.epoch.ncsc.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 12:13:25PM -0400, Stephen Smalley wrote:
> +static int proc_attr_readdir(struct file * filp,
> +	void * dirent, filldir_t filldir)

Umm...  How about having it merged with proc_base_readdir()?  I.e.
have both call the common helper.  Ditto for lookups.

Other than that (and missing check for copy_to_user() return value in
->read()) I don't see any problems here.
