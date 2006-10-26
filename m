Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422800AbWJZTW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422800AbWJZTW2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 15:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422825AbWJZTW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 15:22:28 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:23269 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1422800AbWJZTW2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 15:22:28 -0400
Date: Thu, 26 Oct 2006 20:22:20 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Avi Kivity <avi@argo.co.il>
Cc: Josef Sipek <jsipek@fsl.cs.sunysb.edu>, lkml@pengaru.com,
       linux-kernel@vger.kernel.org
Subject: Re: rename() contention (BUG?)
Message-ID: <20061026192219.GL29920@ftp.linux.org.uk>
References: <20061025205634.GB9100@shells.gnugeneration.com> <20061025211341.GB7128@filer.fsl.cs.sunysb.edu> <454101D6.9050004@argo.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454101D6.9050004@argo.co.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2006 at 08:43:34PM +0200, Avi Kivity wrote:
> The changes make the mutex more efficient, but won't decrease the 
> contention.  It seems that all renames in one filesystem are serialized, 
> and if the renames require I/O (which is certainly the case with nfs), 
> rename throughput is severely limited.

	They are, and for a good reason.  For details see
Documentation/filesystems/directory-locking.

