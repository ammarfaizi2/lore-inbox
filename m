Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261172AbVBCXin@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261172AbVBCXin (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 18:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbVBCXhz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 18:37:55 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16833 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262917AbVBCXhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 18:37:19 -0500
Subject: Re: ext3 extended attributes refcounting wrong?
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mikael Pettersson <mikpe@user.it.uu.se>
Cc: Andrew Morton <akpm@osdl.org>, Andreas Dilger <adilger@clusterfs.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
In-Reply-To: <16898.43219.133783.439910@alkaid.it.uu.se>
References: <16898.43219.133783.439910@alkaid.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107473817.2058.172.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Thu, 03 Feb 2005 23:36:57 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2005-02-03 at 22:42, Mikael Pettersson wrote:
> I believe there is some accounting error in the ext3 code
> for the case when CONFIG_EXT3_FS_XATTR is not selected.
> 
> Whenever any one of my development boxes triggers an fsck
> at boot because some file system, usually /, has been mounted
> sufficiently many times, an inconsistency error occurs

In which kernel(s) exactly?  There was a fix for that applied fairly
recently upstream.

> Extended attribute block N has reference count M, should be M'.

> This occurs on all my boxes, with different CPUs (x86/x86-64/ppc)
> and different chipsets (Intel, Promise, VIA, Apple), and basically
> the only commonalities are:
> - they dual boot the most recent 2.4 and 2.6 kernels, and I switch often
> - all file systems are ext3
> - all XATTR stuff is disabled

I'm not sure how you get this if all xattr stuff is disabled!  Are you
sure you're not using SELinux or ACLs, for example?

--Stephen

