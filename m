Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWBBRRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWBBRRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 12:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932184AbWBBRRc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 12:17:32 -0500
Received: from silver.veritas.com ([143.127.12.111]:32369 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932180AbWBBRRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 12:17:31 -0500
Date: Thu, 2 Feb 2006 17:18:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: yipee <yipeeyipeeyipeeyipee@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: changing physical page
In-Reply-To: <loom.20060202T160457-366@post.gmane.org>
Message-ID: <Pine.LNX.4.61.0602021711110.8796@goblin.wat.veritas.com>
References: <loom.20060202T160457-366@post.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 02 Feb 2006 17:17:31.0467 (UTC) FILETIME=[8CE549B0:01C6281C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2006, yipee wrote:
> 
> On a system running without swap, can there be a case in which the
> kernel decides to move (from one physical page to another)
> a dynamically-allocated page owned by a user program?

I'll assume that when you say "page owned by a user program", you're
meaning a private page, not a shared file page mapped into the program.

If you're asking about what currently happens, the answer is "No".

If you're asking about what you can assume, the answer is "Yes".

The kernel is entitled to move them if it wishes, various people
are interested in page migration, and one application would be if
the system is short of free memory of a particular kind, and your
page is on such memory, and it would help to move it elsewhere.

Hugh
