Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTKMEfM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 23:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262072AbTKMEfL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 23:35:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11189 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262055AbTKMEfG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 23:35:06 -0500
Message-ID: <3FB309E8.4080408@pobox.com>
Date: Wed, 12 Nov 2003 23:34:48 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Prasanna Meda <pmeda@akamai.com>
CC: Andrew Morton <akpm@osdl.org>, tulip-users@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       danner@akamai.com, bmancuso@akamai.com
Subject: Re: Poss. bug in tulip driver since 2.4.7
References: <3FB1832C.35A52F9A@akamai.com> <20031111185419.0ff7a596.akpm@osdl.org> <3FB29377.796E7C6A@akamai.com>
In-Reply-To: <3FB29377.796E7C6A@akamai.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Prasanna Meda wrote:
> No,  you need to bring the for loop outside the loop.
>  - Otherwise we need to reset the setup_frame to
> tp->setup_frame after every loop.
>  - You do not need to set the setup_frm for every
> mc address, we can set once after the complete
> has_table is ready.
> And also the  2.4 code missed a bit in tx_flags.
> 
> We did the following change that makes it identical
> to 2.2 tulip driver, and it worked.
> 
> --- Linux/drivers/net/tulip/tulip_core.c  Fri Oct 10 20:22:29 2003
> +++ linux/drivers/net/tulip/tulip_core.c        Fri Oct 10 20:28:19 2003


Yeah, that looks better...  I'll give it a quick test locally, then push 
it to Linus.

	Jeff



