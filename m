Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUCITnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 14:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbUCITlt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 14:41:49 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:58242 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262142AbUCITlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 14:41:37 -0500
Message-ID: <404E1F29.6060902@tmr.com>
Date: Tue, 09 Mar 2004 14:46:49 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: quadong@users.sourceforge.net
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ipt_helper.c
References: <1w7Xc-6nt-11@gated-at.bofh.it>
In-Reply-To: <1w7Xc-6nt-11@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

quadong@users.sourceforge.net wrote:
> Currently, if you tell iptables to match "-m helper ! --helper ftp" it
> will match any packet from any helper other than FTP.  What it should do
> is match any packet that is not from an FTP helper, included packets that
> are not from any helper (packets from master connections).  Here's the
> fix:
> 
> --- ipt_helper.c.old    2004-03-03 21:34:05.000000000 -0600
> +++ ipt_helper.c        2004-03-04 14:34:17.709903456 -0600
> @@ -48,7 +48,7 @@
> 
>         if (!ct->master) {
>                 DEBUGP("ipt_helper: conntrack %p has no master\n", ct);
> -               return 0;
> +               return info->invert;
>         }
> 
>         exp = ct->master;

I think you can get the functionality you want with the current code, 
but can you get the current functionality which you feel is in error 
after applying your patch?

