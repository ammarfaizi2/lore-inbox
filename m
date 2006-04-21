Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWDUKXM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWDUKXM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 06:23:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWDUKXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 06:23:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:9198 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751034AbWDUKXK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 06:23:10 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20060420171216.4cdd369a.akpm@osdl.org> 
References: <20060420171216.4cdd369a.akpm@osdl.org>  <20060420165927.9968.33912.stgit@warthog.cambridge.redhat.com> 
To: Andrew Morton <akpm@osdl.org>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, steved@redhat.com,
       sct@redhat.com, aviro@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-cachefs@redhat.com, nfsv4@linux-nfs.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] FS-Cache: Provide a filesystem-specific sync'able page bit 
X-Mailer: MH-E 7.92+cvs; nmh 1.1; GNU Emacs 22.0.50.4
Date: Fri, 21 Apr 2006 11:22:55 +0100
Message-ID: <28997.1145614975@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> It would be better to rename PG_checked to PG_fs_misc kernel-wide.

So would deleting PG_checked and changing the PageChecked() macros to:

	#define PageChecked(page)		PageFsMisc((page))
	#define SetPageChecked(page)		SetPageFsMisc((page))
	#define ClearPageChecked(page)		ClearPageFsMisc((page))

be acceptable?  Or would you rather I replaced those too?

David
