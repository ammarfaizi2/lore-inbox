Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965226AbVHJRYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965226AbVHJRYw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVHJRYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:24:52 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:39831 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S965223AbVHJRYw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:24:52 -0400
Subject: Re: [PATCH] remove name length check in a workqueue
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050810100523.0075d4e8.akpm@osdl.org>
References: <1123683544.5093.4.camel@mulgrave>
	 <Pine.LNX.4.58.0508101044110.31617@devserv.devel.redhat.com>
	 <20050810100523.0075d4e8.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 10 Aug 2005 12:24:32 -0500
Message-Id: <1123694672.5134.11.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 10:05 -0700, Andrew Morton wrote:
> Ingo Molnar <mingo@redhat.com> wrote:
> > yeah ... cannot remember why i have done it originally :-|

> Might it be to do with sizeof(task_struct.comm)?

But that's 16 bytes not 10; and anyway, it doesn't have to be unique;
set_task_comm just does a strlcpy from the name, so it will be truncated
(same as for a binary with > 15 character name).

James


