Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317767AbSGZPl4>; Fri, 26 Jul 2002 11:41:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317773AbSGZPl4>; Fri, 26 Jul 2002 11:41:56 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:34294 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317767AbSGZPlz>; Fri, 26 Jul 2002 11:41:55 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3D416603.2000107@snapgear.com> 
References: <3D416603.2000107@snapgear.com>  <3D40A3E4.9050703@snapgear.com> <3D3FA130.6020701@snapgear.com> <9309.1027608767@redhat.com> <9143.1027671559@redhat.com> 
To: gerg <gerg@snapgear.com>
Cc: linux-kernel@vger.kernel.org, David McCullough <davidm@snapgear.com>
Subject: Re: [PATCH]: uClinux (MMU-less) patches against 2.5.28 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Jul 2002 16:45:09 +0100
Message-ID: <5015.1027698309@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


gerg@snapgear.com said:
>  The MAGIC_ROM_PTR support in the uClinux patch adds a field to the
> block_device_operations and file_operations structures that allows
> getting at the physical address in flash.

Sick. Just provide your own mmap() instead. 

>  Disabling processes that are known to be running direct from flash
> sounds workable. (There is no real notion of separating pages under
> uClinux - it is an all or nothing mapping. The text, data, bss, etc
> are always a single contiguous region in the address space).

Yep. For uClinux we could probably get away with that. I don't want to
suggest it for normal Linux though.

> More generous lock that really required for general VM linux, but at
> least the whole process model works for both VM and non-VM linux. I
> would expect this avoids any potential loop/deadlock with pages (going
> on the discussion in follow up emails anyway).

I don't see that many cases where these pages would get locked; I'm not 
convinced it's a problem. But I'm aware of the percentages from the 
previous times I've argued with Alan :)

--
dwmw2


