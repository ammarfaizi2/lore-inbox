Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVEIMcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVEIMcQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 08:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVEIMcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 08:32:16 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:29960 "EHLO
	bne.snapgear.com") by vger.kernel.org with ESMTP id S261305AbVEIMcN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 08:32:13 -0400
Message-ID: <427F5B12.2080505@snapgear.com>
Date: Mon, 09 May 2005 22:44:02 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [uClinux-dev] [PATCH 4/4] nommu - backward compatibility patch
 for mm/nommu.c
References: <0IG400GWS1JUNY@mmp2.samsung.com> <5121.1115632908@redhat.com>
In-Reply-To: <5121.1115632908@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


David Howells wrote:
> Hyok S. Choi <hyok.choi@samsung.com> wrote:
> 
> 
>>-		    (*parent)->vma->vm_end == end)
>>+		    (!len || (*parent)->vma->vm_end == end))
> 
> 
> Please make this configurable. It's bypassing an error case check.

I disagree, I don't think it warrents yet another configuration option.

Most uClinux archiectures don't want to do this size error check - at
least any that rely on the current implementation of light weight uClibc
mmap() based malloc(). And up until recently this was _every_ uClinux
architecture.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
