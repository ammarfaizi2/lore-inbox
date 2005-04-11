Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVDKSCv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVDKSCv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:02:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVDKSCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:02:50 -0400
Received: from kalmia.hozed.org ([209.234.73.41]:26790 "EHLO kalmia.hozed.org")
	by vger.kernel.org with ESMTP id S261865AbVDKSBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:01:08 -0400
Date: Mon, 11 Apr 2005 13:01:08 -0500
From: Troy Benjegerdes <hozer@hozed.org>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC][0/4] InfiniBand userspace verbs implementation
Message-ID: <20050411180107.GF26127@kalmia.hozed.org>
References: <200544159.Ahk9l0puXy39U6u6@topspin.com> <20050411142213.GC26127@kalmia.hozed.org> <52mzs51g5g.fsf@topspin.com> <20050411163342.GE26127@kalmia.hozed.org> <5264yt1cbu.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
In-Reply-To: <5264yt1cbu.fsf@topspin.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 09:56:53AM -0700, Roland Dreier wrote:
>     Troy> Is there a check in the kernel that the memory is actually
>     Troy> mlock()ed?
> 
> No.
> 
>     Troy> What if a malicious (or broken) application does
>     Troy> ibv_reg_mr() but doesn't lock the memory? Does the IB card
>     Troy> get a physical address for a page that might get swapped
>     Troy> out?
> 
> No, the kernel does get_user_pages().  So the pages that the HCA gets
> will not be swapped or used for anything else.  The only thing a
> malicious userspace app can do is screw itself up.
> 
>  - R.

Do we even need the mlock in userspace then?
