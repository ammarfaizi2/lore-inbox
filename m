Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751069AbWJLVhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751069AbWJLVhX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 17:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWJLVhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 17:37:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:3262 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751069AbWJLVhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 17:37:21 -0400
Date: Thu, 12 Oct 2006 14:37:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-kernel@vger.kernel.org, ak@suse.de, Don Mullis <dwm@meer.net>
Subject: Re: [patch 1/7] documentation and scripts
Message-Id: <20061012143713.3f6030c8.akpm@osdl.org>
In-Reply-To: <452df215.7ab6aae9.17a4.58b5@mx.google.com>
References: <20061012074305.047696736@gmail.com>
	<452df215.7ab6aae9.17a4.58b5@mx.google.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2006 16:43:06 +0900
Akinobu Mita <akinobu.mita@gmail.com> wrote:

> +- /debug/*/probability:
> +
> +	likelihood of failure injection, in percent.

The fact that this is a percentage worries me.  When I was playing around
with this sort of thing several years ago I found that even
one-failure-per-thousand was a very high error rate for some testcases. 
This interface would force a minimum failure rate of one-per-hundred, which
is terribly high.

So I wonder if it'd be better to make this have units of "one millionth",
or simply make this tunable "1/(probability of failure)".  So setting it to
1,000,000 gives you one failure per million calls, on average.

