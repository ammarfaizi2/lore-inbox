Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316776AbSE0W3k>; Mon, 27 May 2002 18:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316778AbSE0W3j>; Mon, 27 May 2002 18:29:39 -0400
Received: from jalon.able.es ([212.97.163.2]:10145 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316776AbSE0W3i>;
	Mon, 27 May 2002 18:29:38 -0400
Date: Tue, 28 May 2002 00:29:28 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Use of CONFIG_M686
Message-ID: <20020527222928.GI1848@werewolf.able.es>
In-Reply-To: <20020527222253.GG1848@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.28 J.A. Magallon wrote:
>Hi all...
>
>arch/i386/kernel/traps.c:
>
>#ifndef CONFIG_M686 <=================== which also passes if PII, P4...
>void __init trap_init_f00f_bug(void)
>...

Would it be enough with

#if defined(CONFIG_M586) || defined(CONFIG_M586TSC) || defined(CONFIG_M586MMX)

386-486 do not have the bug, do ?


-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #2 SMP dom may 26 11:20:42 CEST 2002 i686
