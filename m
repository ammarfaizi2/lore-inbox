Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269308AbRHGTDs>; Tue, 7 Aug 2001 15:03:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269312AbRHGTD2>; Tue, 7 Aug 2001 15:03:28 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:32007 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S269308AbRHGTDQ>; Tue, 7 Aug 2001 15:03:16 -0400
Message-ID: <3B703B3B.F02DB414@namesys.com>
Date: Tue, 07 Aug 2001 23:02:19 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Emmanuel Varagnat-AEV010 <Emmanuel_Varagnat-AEV010@email.mot.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: ReiserFS file corruption
In-Reply-To: <3B6E84A1.1A13969@crm.mot.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Emmanuel Varagnat wrote:
> 
> Today, I crashed the kernel and after reboot the source file
> I was working on, was completly unreadable. The size indicated
> by 'ls' seems to be good but with bad data.
> 
> Is this behavior normal (because the FS seems correct) ?
> The worst I hoped is loosing the last save, but not everything.
> 
> Must I patch to a newer version ?
> I'm using a 2.4.3 version.
> 
> Thanks
> 
> -Manu
> 
> PS: Finally I greped the partition and recover my file.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

If your editor rewrites the entire file with every small change (and it probably
does), then if you crash at the wrong moment you can corrupt the entire file. 
If you use emacs or vi, it keeps a backup copy until the write is synced to disk
successfully.

You should definitely use 2.4.7, it is much better.

Hans
