Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270004AbUJHApy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270004AbUJHApy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 20:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269899AbUJHAlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 20:41:09 -0400
Received: from fw.osdl.org ([65.172.181.6]:17586 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269959AbUJHAjm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 20:39:42 -0400
Date: Thu, 7 Oct 2004 17:37:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: chrisw@osdl.org, linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-Id: <20041007173748.0be87160.akpm@osdl.org>
In-Reply-To: <4165E0A7.7080305@yahoo.com.au>
References: <20041007142019.D2441@build.pdx.osdl.net>
	<20041007164044.23bac609.akpm@osdl.org>
	<4165E0A7.7080305@yahoo.com.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> wrote:
>
> >I think a good starting point here will be to revert the most recent
>  >change.
>  >
> 
>  That may fix it for the simple fact that kswapd will just go through its
>  priority loop once then stop.

No it won't.  It'll probably make the priority windup worse.
