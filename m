Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269242AbTGVBSk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 21:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269400AbTGVBSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 21:18:40 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:4038 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S269242AbTGVBSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 21:18:38 -0400
Subject: Re: [PATCH-2.4] [RESEND] Fix deadlock in journal_create
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Mark Fasheh <mark.fasheh@oracle.com>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20030718215421.GF1014@ca-server1.us.oracle.com>
References: <20030718215421.GF1014@ca-server1.us.oracle.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1058793747.1247.9.camel@troy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 22 Jul 2003 02:34:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 2003-07-18 at 22:54, Mark Fasheh wrote:
> Marcelo,
> 	I sent this initially against 2.4.21-rc6 and it didn't make it in
>  -- even though it got Stephen's OK. Here's a resend -- I've identified that
> the bug still exists and 2.4.22-pre7. The patch didn't need to be changed as
> it still applies cleanly.

Marcelo, please apply --- the jbd internal journal create code is in
practice unused by ext3 these days now that e2fsprogs groks journals,
but other filesystems wanting to use that code will need this patch.

Cheers,
 Stephen


