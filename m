Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319861AbSINIrT>; Sat, 14 Sep 2002 04:47:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319862AbSINIrT>; Sat, 14 Sep 2002 04:47:19 -0400
Received: from hermes.domdv.de ([193.102.202.1]:39954 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S319861AbSINIrT>;
	Sat, 14 Sep 2002 04:47:19 -0400
Message-ID: <3D82F8F9.4080604@domdv.de>
Date: Sat, 14 Sep 2002 10:53:13 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Urban Widmark <urban@teststation.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: compile warning fix for smb_debug.h
References: <Pine.LNX.4.44.0209141023420.32154-100000@cola.enlightnet.local>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm just wary about the extra blank which is error prone. Otherwise 
there's no problem.

Urban Widmark wrote:
> On Fri, 13 Sep 2002, Andreas Steinmetz wrote:
> 
> 
>>Hi,
>>attached is a fix for gcc 3.2 deprecated usage warnings for __FUNCTION__ 
>>in smb_debug.h. As gcc 2.95.3 doesn't issue the warning and can't handle 
>>the new macro there's a macro selection based on the compiler major 
>>version. Patch is against 2.4.20pre7.
> 
> 
> Why not just take the version from 2.5?
> Or is there a problem with this one too and gcc2.95.3?
> 
> #ifdef SMBFS_PARANOIA
> # define PARANOIA(f, a...) printk(KERN_NOTICE "%s: " f, __FUNCTION__ , ## a)
> #else
> # define PARANOIA(f, a...) do { ; } while(0)
> #endif
> 
> etc.
> 
> Note the extra space ...
> 
> /Urban
> 
> 

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

