Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262049AbSI3NG1>; Mon, 30 Sep 2002 09:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262050AbSI3NG1>; Mon, 30 Sep 2002 09:06:27 -0400
Received: from mg01.austin.ibm.com ([192.35.232.18]:9113 "EHLO
	mg01.austin.ibm.com") by vger.kernel.org with ESMTP
	id <S262049AbSI3NG0>; Mon, 30 Sep 2002 09:06:26 -0400
Message-ID: <3D98488B.DF793D13@us.ibm.com>
Date: Mon, 30 Sep 2002 07:50:19 -0500
From: Jon Grimm <jgrimm2@us.ibm.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: Luc Van Oostenryck <luc.vanoostenryck@easynet.be>,
       Thomas Molina <tmolina@cox.net>,
       lksctp-developers@lists.sourceforge.net,
       Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Lksctp-developers] Re: (more) Sleeping function called from illegal 
 context...
References: <20020927233044.GA14234@kroah.com> <3D94EEBF.D6328392@digeo.com> <3D94FB89.40400@easynet.be> <3D950590.1F9FBDC6@digeo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks.  We'll fix it up.

Best Regards,
Jon Grimm

Andrew Morton wrote:
> 

> 
> sctp_v4_get_local_addr_list():
> 
>                 /* XXX BUG: sleeping allocation with lock held -DaveM */
>                 addr = t_new(struct sockaddr_storage_list, GFP_KERNEL);
> 
> Is true.  We're holding dev_base_lock, inetdev_lock and in_dev->lock
> here.
>
