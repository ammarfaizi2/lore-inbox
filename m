Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261675AbVCCNoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbVCCNoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 08:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVCCNoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 08:44:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13492 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261676AbVCCNmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 08:42:35 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20050302143934.30d191d7.akpm@osdl.org> 
References: <20050302143934.30d191d7.akpm@osdl.org>  <20050302090734.5a9895a3.akpm@osdl.org> <9420.1109778627@redhat.com> <31789.1109799287@redhat.com> <20050302135146.2248c7e5.akpm@osdl.org> <Pine.LNX.4.58.0503021423420.25732@ppc970.osdl.org> 
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>, davidm@snapgear.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] BDI: Provide backing device capability information 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Thu, 03 Mar 2005 13:42:10 +0000
Message-ID: <13844.1109857330@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> Yup.  In this application the fields are initialised once (usually at
> compile time) and are never modified.

That's not exactly so. The block layer appears to modify them. See
blk_queue_make_request() in ll_rw_blk.c.

David
