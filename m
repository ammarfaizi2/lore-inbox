Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263632AbSITV3c>; Fri, 20 Sep 2002 17:29:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263770AbSITV3b>; Fri, 20 Sep 2002 17:29:31 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:33029
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S263632AbSITV3b>; Fri, 20 Sep 2002 17:29:31 -0400
Subject: Re: [PATCH] list_head debugging?
From: Robert Love <rml@tech9.net>
To: Zach Brown <zab@zabbo.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020920165304.A4588@bitchcake.off.net>
References: <20020920165304.A4588@bitchcake.off.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 20 Sep 2002 17:34:36 -0400
Message-Id: <1032557677.966.863.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-09-20 at 16:53, Zach Brown wrote:

> A friend recently was bitten by passing a list_head from list_for_each
> to a code path that later moved the list_head around.  Does the attached
> patch re-create some debugging wheel that's hiding off in a corner
> somewhere?
> 
> Beyond catching the obvious use of uninitialized things, it also seems
> to catch double adds, double deletes, and simple deletes of 'pos' in
> list_for_each.  it even seems to bark about the seemingly hard-to-detect
> movement of 'pos' from the iterating list to another, but probably only
> in the rare case where you're unconditionally moving all 'pos' in the
> loop body.  (you eventually iterate into the second list's head and try
> to add it to itself)

Hey, cool!

Yes, I think a lot of people would be all for something like this as a
CONFIG_DEBUG_LISTS or such.  Very nice.

	Robert Love

