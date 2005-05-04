Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVEDB0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVEDB0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 21:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVEDB0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 21:26:30 -0400
Received: from fire.osdl.org ([65.172.181.4]:8165 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261974AbVEDB01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 21:26:27 -0400
Date: Tue, 3 May 2005 18:25:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jason Baron <jbaron@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty races
Message-Id: <20050503182554.02af99e8.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0505032101540.22921@dhcp83-105.boston.redhat.com>
References: <Pine.LNX.4.61.0504201227370.13902@dhcp83-105.boston.redhat.com>
	<20050425232251.6ffac97c.akpm@osdl.org>
	<Pine.LNX.4.61.0504260922001.26392@dhcp83-105.boston.redhat.com>
	<20050502232721.19dde63d.akpm@osdl.org>
	<Pine.LNX.4.61.0505030923560.10633@dhcp83-105.boston.redhat.com>
	<20050503175023.627bd904.akpm@osdl.org>
	<Pine.LNX.4.61.0505032101540.22921@dhcp83-105.boston.redhat.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jason Baron <jbaron@redhat.com> wrote:
>
> The patch I proposed fixes the open vs. open race using the tty_sem. The 
>  open vs. close race is closed by removing locking. Less locking seems 
>  better to me. 

But the additional locking is only temporary.  Once we thing the tty_sem
converage is complete, the lock_kernel()s get removed.  

>  If you're still not happy, I'll wrap the close path in the tty_sem...

Would be appreciated, please.
