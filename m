Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314360AbSDROKS>; Thu, 18 Apr 2002 10:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314361AbSDROKR>; Thu, 18 Apr 2002 10:10:17 -0400
Received: from [203.117.131.12] ([203.117.131.12]:57482 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S314360AbSDROKP>; Thu, 18 Apr 2002 10:10:15 -0400
Message-ID: <3CBED3C0.1020203@metaparadigm.com>
Date: Thu, 18 Apr 2002 22:10:08 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020412 Debian/0.9.9-6
MIME-Version: 1.0
To: Martin Rode <martin.rode@programmfabrik.de>
Cc: Keith Owens <kaos@sgi.com>, linux-kernel@vger.kernel.org
Subject: Re: Callbacks to userspace from VFS ?
In-Reply-To: <30229.1019092935@ocs3.intra.ocs.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fam and imon also sound like they would do what you want to do.

fam works with or without the imon (inode monitor) kernel extension.
If imon is present, then fam doesn't need to poll for changes on interested
files/directories and operation is much more efficient. I think imon still
needs some work from reading the docs (is only version 0.0.2).

~mc

http://oss.sgi.com/projects/fam/

Keith Owens wrote:

>On 17 Apr 2002 16:21:13 +0200, 
>Martin Rode <martin.rode@programmfabrik.de> wrote:
>
>>after programming at least 10 scripts polling a what we call
>>"hot-folder" for new files I had the idea to integrate call backs into
>>the file system layer of the linux kernel.
>>
>>I would like to tell the kernel to callback my program whenever a file
>>or directory is being inserted, updated or deleted.
>>
>
>dnotify already exists, although you have to work out what has changed.
>
>XFS implements DMAPI (Data Management API) event callouts which give
>much more details.  DMAPI is designed for full blown Hierarchical
>Storage Managements systems.
>http://www.opengroup.org/pubs/catalog/c429.htm to purchase the DMAPI
>standard, there is also a free (with registration) online standard.
>
>Not speaking for SGI.
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>


