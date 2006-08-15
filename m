Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWHOAnY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWHOAnY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 20:43:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbWHOAnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 20:43:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43185 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965035AbWHOAnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 20:43:23 -0400
Date: Mon, 14 Aug 2006 17:43:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [3/3] Support piping into commands in
 /proc/sys/kernel/core_pattern
Message-Id: <20060814174319.94294a54.akpm@osdl.org>
In-Reply-To: <20060814112732.684D313BD9@wotan.suse.de>
References: <20060814 127.183332000@suse.de>
	<20060814112732.684D313BD9@wotan.suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006 13:27:32 +0200 (CEST)
Andi Kleen <ak@suse.de> wrote:

> The core dump proces will run with the privileges and in the name space
> of the process that caused the core dump.

Don't think so.   __call_usermodehelper() is executed by the khelper kernel thread.
