Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262128AbSJPLH2>; Wed, 16 Oct 2002 07:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264762AbSJPLH2>; Wed, 16 Oct 2002 07:07:28 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:16821 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S262128AbSJPLH1>; Wed, 16 Oct 2002 07:07:27 -0400
Message-ID: <3DAD49F0.8050808@quark.didntduck.org>
Date: Wed, 16 Oct 2002 07:13:52 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Melkor Ainur <melkorainur@yahoo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: user space virtual address to a vm_area_struct
References: <20021016091011.9346.qmail@web21204.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Melkor Ainur wrote:
> Hi,
> 
> Is there a recommended way for a driver to take an
> application provided virtual address while executing
> in the syscall context of that same application and
> find the corresponding vm_area_struct (if exists for
> that address) that spans that virtual address?
> 
> Melkor

down_read(current->mm->mmap_sem);
vma = find_vma(current->mm, address);
...
up_read(current->mm->mmap_sem);

--
				Brian Gerst


