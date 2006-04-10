Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWDJJ6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWDJJ6L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 05:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751108AbWDJJ6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 05:58:11 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22488 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751107AbWDJJ6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 05:58:10 -0400
Date: Mon, 10 Apr 2006 01:57:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org, sam@ravnborg.org
Subject: Re: [PATCH 11/19] kconfig: move .kernelrelease
Message-Id: <20060410015727.69b5c1f6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604091728560.23148@scrub.home>
References: <Pine.LNX.4.64.0604091728560.23148@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> This moves the .kernelrelease file into include/config directory.
>  Remove its generation from the config step, if the config step doesn't
>  leave a proper .config behind, it triggers a call to silentoldconfig.
>  Instead its generation can be done via proper dependencies.

Well that was a pita.  I was using that file in my kernel installation
script.

Your changelog says what the patch does, but gives no indication of why it
did it.

What do we get back for the breakage which this will cause?

Now I'm going to have to look for both .kernelrelease and
include/config/kernel.release and work out which one has the more recent
mtime.  grr.

