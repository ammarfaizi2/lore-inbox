Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263103AbTEGKmf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 06:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263126AbTEGKmf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 06:42:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53433 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263103AbTEGKmd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 06:42:33 -0400
Date: Wed, 7 May 2003 11:55:07 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Linus Torvalds <torvalds@transmeta.com>, Andrew Morton <akpm@digeo.com>,
       lkml <linux-kernel@vger.kernel.org>,
       lsm <linux-security-module@wirex.com>
Subject: Re: [PATCH] Move security_d_instantiate hook calls 2.5.69
Message-ID: <20030507105507.GP10374@parcelfarce.linux.theplanet.co.uk>
References: <1052238293.1377.1002.camel@moss-huskers.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052238293.1377.1002.camel@moss-huskers.epoch.ncsc.mil>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 12:24:53PM -0400, Stephen Smalley wrote:
> This patch against 2.5.69 moves the security_d_instantiate hook calls in
> d_instantiate and d_splice_alias after the inode has been attached to
> the dentry.  This change is necessary so that security modules can
> internally call the getxattr inode operation (which takes a dentry
> parameter) from this hook to obtain the inode security label.  Al, if
> you approve of this change, please acknowledge.  If not, please advise
> as to what must change.  Thanks.

No objections.
