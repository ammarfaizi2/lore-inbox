Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbUBUD6X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 22:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261507AbUBUD6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 22:58:23 -0500
Received: from fw.osdl.org ([65.172.181.6]:20642 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261505AbUBUD6W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 22:58:22 -0500
Date: Fri, 20 Feb 2004 19:58:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       brugolsky@telemetry-investments.com
Subject: Re: [PATCH][2/4] poll()/select() timeout behavior
Message-Id: <20040220195840.36b3a76e.akpm@osdl.org>
In-Reply-To: <20040220210221.GC1912@ti19.telemetry-investments.com>
References: <20040220210221.GC1912@ti19.telemetry-investments.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Bill Rugolsky Jr." <brugolsky@telemetry-investments.com> wrote:
>
> This patch cause select() to return EINVAL when passed an un-normalized
> timeval usec

Why?  The current behaviour is to do the right thing when passed a tv_usec
which is greater than 1,000,000.  Why not retain that?

