Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbSKNVgM>; Thu, 14 Nov 2002 16:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265246AbSKNVgM>; Thu, 14 Nov 2002 16:36:12 -0500
Received: from fmr04.intel.com ([143.183.121.6]:13762 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S261596AbSKNVgL>; Thu, 14 Nov 2002 16:36:11 -0500
Message-ID: <3DD41849.20306@unix-os.sc.intel.com>
Date: Thu, 14 Nov 2002 13:40:25 -0800
From: Rohit Seth <rseth@unix-os.sc.intel.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: William Lee Irwin III <wli@holomorphy.com>, Andrew Morton <akpm@digeo.com>,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] remove hugetlb syscalls
References: <20021113184555.B10889@redhat.com> <20021114203035.GF22031@holomorphy.com> <20021114154809.D20258@redhat.com> <20021114210220.GM23425@holomorphy.com> <20021114161134.E20258@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

>Oracle does not run as root, so they can't even use the syscalls 
>directly.  At least with hugetlbfs we can chmod the filesystem to be 
>owned by the oracle user.
>
>		-ben
>
>  
>
Strictly speaking user don't have to be root.  Currently the syscall 
only requires users to have root as one of the supplementary groups (and 
that is how Oracle is actually using these syscalls).  And if 
CAP_IPC_LOCK (to make it coherent with fs side of the world) is what is 
preferdto provide access to hugepages then that change is simple also. 
 Don't need to do any chmod.

rohit


