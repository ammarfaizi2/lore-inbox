Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263865AbTE0PZk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 11:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263866AbTE0PZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 11:25:40 -0400
Received: from garnet.acns.fsu.edu ([146.201.2.25]:55238 "EHLO
	garnet.acns.fsu.edu") by vger.kernel.org with ESMTP id S263865AbTE0PZi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 11:25:38 -0400
Message-ID: <3ED38670.4000108@cox.net>
Date: Tue, 27 May 2003 11:38:24 -0400
From: David van Hoose <davidvh@cox.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.70-bk1] Compilation failures ppa.c imm.c
References: <3ED383E7.6080109@cox.net>
In-Reply-To: <3ED383E7.6080109@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David van Hoose wrote:
> There is a compilation error on line 280 of ppa.c.
> Should
>     if (ppa_hosts[i] == host)
> Be
>     if ((struct Scsi_Host *)&ppa_hosts[i] == host)
> ??

Actually.. Looking at imm.c, I think that was supposed to be:
       if (ppa_hosts[i].host == host->host_no)

Correct?

-David

