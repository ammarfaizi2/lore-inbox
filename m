Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263763AbREYPWZ>; Fri, 25 May 2001 11:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263764AbREYPWQ>; Fri, 25 May 2001 11:22:16 -0400
Received: from cmn2.cmn.net ([206.168.145.10]:57376 "EHLO cmn2.cmn.net")
	by vger.kernel.org with ESMTP id <S263763AbREYPWG>;
	Fri, 25 May 2001 11:22:06 -0400
Message-ID: <3B0E7891.5030803@valinux.com>
Date: Fri, 25 May 2001 09:21:53 -0600
From: Jeff Hartmann <jhartmann@valinux.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2 i686; en-US; 0.8) Gecko/20010215
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] free bugs in 2.4.4 and 2.4.4-ac8
In-Reply-To: <E1533qI-0005jT-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> 
>> 		return;
>> /u2/engler/mc/oses/linux/2.4.4-ac8/drivers/char/drm/gamma_dma.c:573:gamma_dma_send_buffers: ERROR:FREE:561:573: WARN: Use-after-free of "last_buf"! set by 'drm_free_buffer':561
>> 		DRM_DEBUG("%d running\n", current->pid);
> 
> 
> Left for the XFree folk
> 

This is a false positive, drm_free_buffer doesn't free any memory 
associated with a buffer.  This code construct is fine.

-Jeff

