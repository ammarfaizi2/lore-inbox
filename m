Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291823AbSBAQKN>; Fri, 1 Feb 2002 11:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291825AbSBAQKD>; Fri, 1 Feb 2002 11:10:03 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:28920 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S291823AbSBAQJz>; Fri, 1 Feb 2002 11:09:55 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020201151221.GA8404@vana.vc.cvut.cz> 
In-Reply-To: <20020201151221.GA8404@vana.vc.cvut.cz>  <20020131.222643.85689058.davem@redhat.com> <E16WfDe-0005Jd-00@the-village.bc.nu> <20020201095510.D17412@havoc.gtf.org> 
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: torvalds@transmeta.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "David S. Miller" <davem@redhat.com>, kaos@ocs.com.au,
        linux-kernel@vger.kernel.org, paulus@samba.org, davidm@hpl.hp.com,
        ralf@gnu.org, garzik@havoc.gtf.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 16:08:49 +0000
Message-ID: <17075.1012579729@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


vandrove@vc.cvut.cz said:
>   I decided to use fs_initcall level, as nobody is using this yet. If
> jffs2 will get initialized by fs_initcall, we'll have to switch
> init_crc32 from fs_initcall to arch_initcall or even sooner - crc32
> initialization needs only working kmalloc, nothing else (and it could
> use static buffer happilly, as zeroes compress very good), so
> subsys_initcall could work too. 

JFFS2 won't actually use the crc32 routines till it tries to mount a file 
system, so you shouldn't have a problem unless you try to mount the rootfs 
before init_crc32().


--
dwmw2


