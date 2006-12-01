Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936484AbWLAOlC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936484AbWLAOlC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 09:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936507AbWLAOlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 09:41:02 -0500
Received: from wr-out-0506.google.com ([64.233.184.232]:61151 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S936490AbWLAOlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 09:41:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=su6rDScAx239+EVTCEHMwOcynmVmM2jcQR9dbigHhqyXrpqUgw6f63HEhfnxd1oniXYNNSnvicIJ+cQW68N5GY9ah0Lm2N9vPp1LEdrpqwlbDqEvy+WhS/co0KhYrJ1uK2FiRGVKRlkTbqxSqoCel+yBZyfjfSMLtxqWbu4I+Fw=
Message-ID: <9a8748490612010640t7ed7119bj57f45c8b47289719@mail.gmail.com>
Date: Fri, 1 Dec 2006 15:40:35 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "linux err" <linux_err@yahoo.com>
Subject: Re: Core file size?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4288.39070.qm@web56507.mail.re3.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4288.39070.qm@web56507.mail.re3.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/06, linux err <linux_err@yahoo.com> wrote:
> Does anyone know what determines the size of a core
> dump? I have a process running out of memory (it
> allocates about 3GB) - but the size of core varies
> (between 2-3GB) depending on how much the process
> wrote on the allocated memory.
>

Makes perfect sense. The core dump contains the memory of the process,
so if the process has 3GB in use then the core file will be 3GB.

You can limit the size of core dumps with "ulimit -c"


> Also, the time it takes to write the core (same size)
> varies??
>
Could be many reasons for that. If the load on the machine varies the
time to perform any given action will vary as well.


> I briefly looked at elf_core_dump and get_user_pages()
> in binfmt_elf.c. Is there any documentation on this?
> Or anyone knows how it works?
>
http://x86.ddj.com/ftp/manuals/tools/elf.pdf
http://en.wikipedia.org/wiki/Core_dump


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
