Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267721AbSLSXlO>; Thu, 19 Dec 2002 18:41:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267724AbSLSXlO>; Thu, 19 Dec 2002 18:41:14 -0500
Received: from hell.ascs.muni.cz ([147.251.60.186]:55168 "EHLO
	hell.ascs.muni.cz") by vger.kernel.org with ESMTP
	id <S267721AbSLSXlN>; Thu, 19 Dec 2002 18:41:13 -0500
Date: Fri, 20 Dec 2002 00:49:13 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Colin Slater <hoho@tacomeat.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: 2.5.52-bk4
Message-ID: <20021219234913.GA586@mail.muni.cz>
References: <20021219.181921.41185800.hoho@tacomeat.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021219.181921.41185800.hoho@tacomeat.net>
User-Agent: Mutt/1.4i
X-Muni: zakazka, vydelek, firma, komerce, vyplata
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, Mossad, Iraq, Pentagon, WTC, president, assassination, A-bomb, kua, vic joudu uz neznam
X-policie-CR: Neserte mi nebo ukradnu, vyloupim, vybouchnu, znasilnim, zabiju, podpalim, umucim, podriznu, zapichnu a vubec vsechno
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 19, 2002 at 06:19:21PM -0500, Colin Slater wrote:
>  	if (raw_proc_init())
>  		goto out_raw;
> -	if (tcp_proc_init())
> +	if (!proc_net_create("tcp", 0, tcp_get_info))

I have got these:
net/built-in.o(.init.text+0x1489): In function `ipv4_proc_init':
: undefined reference to `proc_net_create'
net/built-in.o(.init.text+0x14be): In function `ipv4_proc_init':
: undefined reference to `proc_net_remove'
make: *** [.tmp_vmlinux1] Error 1


-- 
Luká¹ Hejtmánek
