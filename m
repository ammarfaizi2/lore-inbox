Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbSL0ALg>; Thu, 26 Dec 2002 19:11:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264690AbSL0ALg>; Thu, 26 Dec 2002 19:11:36 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:21745 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S264688AbSL0ALf>;
	Thu, 26 Dec 2002 19:11:35 -0500
Date: Fri, 27 Dec 2002 01:19:42 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-pre on SMP-HT exports bad AT_PLATFORM
Message-ID: <20021227001942.GA9110@werewolf.able.es>
References: <20021226224656.GC1563@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021226224656.GC1563@werewolf.able.es>; from jamagallon@able.es on Thu, Dec 26, 2002 at 23:46:56 +0100
X-Mailer: Balsa 2.0.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.26 J.A. Magallón wrote:
> Hi all...
> 
> Continuing with the glibc-2.3.1 saga, I have tested 2.4.21-pre2. It also
> fails. glibc can not get a correct AT_PLATFORM when the kernel is run
> on an hyperthreaded smp box.
> 
[...]
> 
> ld.so is a modified one to print AT_PLATFORM, by Gwenole@mandrakesoft. The
> loader used for the /bin/true test is the standard one.
> 

Sorry, forgot to say that you can get similar results with:

werewolf:~> LD_SHOW_AUXV=1 /bin/true
AT_HWCAP:    fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 mmx fxsr
AT_PAGESZ:      4096
AT_CLKTCK:      100
AT_PHDR:        0x8048034
AT_PHENT:       32
AT_PHNUM:       6
AT_BASE:        0x15556000
AT_FLAGS:       0x0
AT_ENTRY:       0x8048920
AT_UID:         3001
AT_EUID:        3001
AT_GID:         3000
AT_EGID:        3000
AT_PLATFORM:    i686

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre2-jam1 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
