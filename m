Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317056AbSF1EdJ>; Fri, 28 Jun 2002 00:33:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317058AbSF1EdI>; Fri, 28 Jun 2002 00:33:08 -0400
Received: from 12-237-16-92.client.attbi.com ([12.237.16.92]:9856 "EHLO
	ledzep.dyndns.org") by vger.kernel.org with ESMTP
	id <S317056AbSF1EdH>; Fri, 28 Jun 2002 00:33:07 -0400
Message-ID: <3D1BE786.5070100@attbi.com>
Date: Thu, 27 Jun 2002 23:35:18 -0500
From: Jordan Breeding <jordan.breeding@attbi.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Contreras <al593181@mail.mty.itesm.mx>
CC: linux-kernel@vger.kernel.org
Subject: Re: Very weird bug in fs/exec.c
References: <20020627211922.GA14184@zion.mty.itesm.mx>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Contreras wrote:
> Hi,
> 
> I've found a weird bug that seems to only happend in my system. It makes
> recursive makes segfault, like:
> 
> test:
> 	( make -v )
> 
> After a lot of work tracking it I finally found what causes it, I'm attaching
> the patch that generates the bug, it's a diff from 2.5.18 to 2.5.19.
> 
> I'm saying it's weird because just adding a printk before do_execve returns
> successfully makes the bug dissapear.
> 
> BTW, yes, my system is very special.
> 


I can verify that a lot of weird problems (compiles failing with seg 
faults, `java -version` not running, other java programs not running and 
in most cases the program in question would succeed if I ran it through 
strace first) I was seeing in kernels after 2.5.18 (ie. 2.5.20-dj1, 
2.5.20-dj4, 2.5.23-dj1 and 2.5.24-dj1) go away if I reverse the patch 
included in the original email for this thread.  Glad to find out what 
had been causing that mess!  Thanks.

Jordan


