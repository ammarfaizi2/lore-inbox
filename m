Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264539AbUAOBjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 20:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264949AbUAOBhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 20:37:31 -0500
Received: from dp.samba.org ([66.70.73.150]:19079 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264292AbUAOBh0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 20:37:26 -0500
Date: Thu, 15 Jan 2004 10:10:44 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Eric Blade <eblade@blackmagik.dynup.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dmesg gives me request_module fail 2.6.1
Message-Id: <20040115101044.292e36f8.rusty@rustcorp.com.au>
In-Reply-To: <20040113112123.21902bbf.eblade@blackmagik.dynup.net>
References: <20040113112123.21902bbf.eblade@blackmagik.dynup.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 11:21:23 -0500
Eric Blade <eblade@blackmagik.dynup.net> wrote:

> request_module: failed /sbin/modprobe -- net-pf-10. error = 65280

A more recent module-init-tools will not return failure when asked to
modprobe something it's never heard of (with -q, which the kernel uses,
despite that misleading message)  eg:

	modprobe -q -- aalsfdhjlsfdjkhsfhkh

Will "succeed".
Cheers,
Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
