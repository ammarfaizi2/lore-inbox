Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263359AbSIPXoN>; Mon, 16 Sep 2002 19:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263374AbSIPXoM>; Mon, 16 Sep 2002 19:44:12 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12556 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263359AbSIPXoM>;
	Mon, 16 Sep 2002 19:44:12 -0400
Message-ID: <3D866DD5.4080207@mandrakesoft.com>
Date: Mon, 16 Sep 2002 19:48:37 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: dwmw2@infradead.org, linux-kernel@vger.kernel.org, todd-lkml@osogrande.com,
       hadi@cyberus.ca, tcw@tempest.prismnet.com, netdev@oss.sgi.com,
       pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
References: <12116.1032216780@redhat.com>	<12293.1032217399@redhat.com>	<3D86645F.5030401@mandrakesoft.com> <20020916.160210.70782700.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
>    From: Jeff Garzik <jgarzik@mandrakesoft.com>
>    Date: Mon, 16 Sep 2002 19:08:15 -0400
>    
>    I was rather disappointed when file->file sendfile was [purposefully?] 
>    broken in 2.5.x...
> 
> What change made this happen?


I dunno when it happened, but 2.5.x now returns EINVAL for all 
file->file cases.

In 2.4.x, if sendpage is NULL, file_send_actor in mm/filemap.c faked a 
call to fops->write().
In 2.5.x, if sendpage is NULL, EINVAL is unconditionally returned.

