Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVCJFYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVCJFYm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 00:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVCJFTr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 00:19:47 -0500
Received: from fire.osdl.org ([65.172.181.4]:27797 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261745AbVCJFSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 00:18:01 -0500
Date: Wed, 9 Mar 2005 21:17:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Schmid <webmaster@rapidforum.com>
Cc: greearb@candelatech.com, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
Message-Id: <20050309211730.24b4fc93.akpm@osdl.org>
In-Reply-To: <422F93CE.3060403@rapidforum.com>
References: <4229E805.3050105@rapidforum.com>
	<422BAAC6.6040705@candelatech.com>
	<422BB548.1020906@rapidforum.com>
	<422BC303.9060907@candelatech.com>
	<422BE33D.5080904@yahoo.com.au>
	<422C1D57.9040708@candelatech.com>
	<422C1EC0.8050106@yahoo.com.au>
	<422D468C.7060900@candelatech.com>
	<422DD5A3.7060202@rapidforum.com>
	<422F8A8A.8010606@candelatech.com>
	<422F8C58.4000809@rapidforum.com>
	<422F9259.2010003@candelatech.com>
	<422F93CE.3060403@rapidforum.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schmid <webmaster@rapidforum.com> wrote:
>
>  > So, maybe a VM problem?  That would be a good place to focus since
>  > I think we can be fairly certain it isn't a problem in just the
>  > networking code.  Otherwise, my tests would show lower bandwidth.
> 
>  Thanks to your tests I am really sure that its no network-code problem anymore. But what I THINK it 
>  is: The network is allocating buffers dynamically and if the vm doesnt provide that buffers fast 
>  enough, it locks as well.

Did anyone have a 100-liner which demonstrates this problem?

The output of `vmstat 1' when the thing starts happening would be interesting.
