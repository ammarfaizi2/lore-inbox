Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932521AbWHCOdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWHCOdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 10:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbWHCOdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 10:33:19 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:52890 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932521AbWHCOdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 10:33:18 -0400
Date: Thu, 3 Aug 2006 15:33:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk, herbert@13thfloor.at,
       hch@infradead.org
Subject: Re: [PATCH 02/28] r/o bind mount prepwork: move open_namei()'s vfs_create()
Message-ID: <20060803143317.GB920@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, linux-kernel@vger.kernel.org,
	viro@ftp.linux.org.uk, herbert@13thfloor.at
References: <20060801235240.82ADCA42@localhost.localdomain> <20060801235241.D7516044@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060801235241.D7516044@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2006 at 04:52:41PM -0700, Dave Hansen wrote:
> 
> The code around vfs_create() in open_namei() is getting a
> bit too complex.  Right now, there is at least the reference
> count on the dentry, and the i_mutex to worry about.  Soon,
> we'll also have mnt_writecount.
> 
> So, break the vfs_create() call out of open_namei(), and
> into a helper function.  This duplicates the call to
> may_open(), but that isn't such a bad thing since the
> arguments (acc_mode and flag) were being heavily massaged
> anyway.
> 
> Later in the series, we'll add the mnt_writecount handling
> around this new function call.
> 

Ok.  Again please send to Andrew ASAP.

