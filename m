Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbWG3SeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbWG3SeX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932411AbWG3SeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:34:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:14561 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932420AbWG3SeW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:34:22 -0400
Date: Sun, 30 Jul 2006 11:34:16 -0700
From: Paul Jackson <pj@sgi.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, jesper.juhl@gmail.com, akpm@osdl.org
Subject: Re: [PATCH 01/12] making the kernel -Wshadow clean - fix mconf
Message-Id: <20060730113416.7c1d8f80.pj@sgi.com>
In-Reply-To: <200607301835.35053.jesper.juhl@gmail.com>
References: <200607301830.01659.jesper.juhl@gmail.com>
	<200607301835.35053.jesper.juhl@gmail.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper wrote:
> -		cprint("%s", filename);
> +		cprint("%s", config_filename);

Something seems strange here to me.  It looks like you are sometimes
resolving the shadowed symbols by making the more local symbol have the
longer name.

I'd have expected that the global symbol would be the one with the
longer, more elaborate name.

In other words, I would have expected that we would avoid having global
names such as (from your other patches in this set):

    filename
    scroll
    instr
    up
    sum
    state
    rep
    complete
    irq

Perhaps I am misreading this patch set?

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
