Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267132AbTBIAe5>; Sat, 8 Feb 2003 19:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267135AbTBIAe5>; Sat, 8 Feb 2003 19:34:57 -0500
Received: from postfix4-2.free.fr ([213.228.0.176]:5782 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP
	id <S267132AbTBIAe4>; Sat, 8 Feb 2003 19:34:56 -0500
Message-ID: <3E45B3FF.E687EF48@free.fr>
Date: Sun, 09 Feb 2003 02:50:55 +0100
From: Jerome de Vivie <jerome.devivie@free.fr>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap inside kernel memory.
References: <3E45A7C4.8F1EBDFA@free.fr> <Pine.LNX.4.50L.0302082159460.12742-100000@imladris.surriel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
> 
> On Sun, 9 Feb 2003, Jerome de Vivie wrote:
> 
> > "mmap" seems to be design for mapping file or device inside a process
> > memory. Is it possible to map a file into the kernel virtual memory ?
> 
> In theory yes (using vmalloc space), but you really don't want to.

Yes, it's very tricky ! I have (naïvly) try this:

vaddr=vmalloc(len);
do_mmap(file ,kvaddr ,len ,PROT_READ|PROT_WRITE ,MAP_FIXED|MAP_PRIVATE
,0);

Here, do_mmap check if the addresse match inside current process and
return me -ENOMEM. Are there others functions which i could use to
associate this file and a vmalloc'ed space ?


j.

-- 
Jérôme de Vivie
