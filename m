Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbTIBL3n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 07:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbTIBL3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 07:29:43 -0400
Received: from holomorphy.com ([66.224.33.161]:52972 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261236AbTIBL3l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 07:29:41 -0400
Date: Tue, 2 Sep 2003 04:30:38 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Takao Indoh <indou.takao@soft.fujitsu.com>
Cc: Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
Subject: Re: cache limit
Message-ID: <20030902113038.GK4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Takao Indoh <indou.takao@soft.fujitsu.com>,
	Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org
References: <20030827113646.GC4306@holomorphy.com> <23C371405B0858indou.takao@soft.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23C371405B0858indou.takao@soft.fujitsu.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 07:52:51PM +0900, Takao Indoh wrote:
> According to this information, many I/O increase pagecache and cause
> memory shortage.
> fadvise may be effective, but fadvise always releases cache
> even if there are enough free memory, and may degrade performance.
> In the case of /proc tunable,
> pagecache is not released until system memory become lack.
[...]
> If so, limiting pagecache seems to be effective for DBMS.

There are reasons why databases use raw io and direct io; this is one
of them. I'd say the kernel shouldn't try to engage in such tunable
shenanigans.


-- wli
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
On Tue, Sep 02, 2003 at 07:52:51PM +0900, Takao Indoh wrote:
> According to this information, many I/O increase pagecache and cause
> memory shortage.
> fadvise may be effective, but fadvise always releases cache
> even if there are enough free memory, and may degrade performance.
> In the case of /proc tunable,
> pagecache is not released until system memory become lack.
[...]
> If so, limiting pagecache seems to be effective for DBMS.

There are reasons why databases use raw io and direct io; this is one
of them. I'd say the kernel shouldn't try to engage in such tunable
shenanigans.


-- wli
