Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319775AbSIMU1C>; Fri, 13 Sep 2002 16:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319783AbSIMU1C>; Fri, 13 Sep 2002 16:27:02 -0400
Received: from hermes.domdv.de ([193.102.202.1]:21765 "EHLO zeus.domdv.de")
	by vger.kernel.org with ESMTP id <S319775AbSIMU1B>;
	Fri, 13 Sep 2002 16:27:01 -0400
Message-ID: <3D824AD8.8050501@domdv.de>
Date: Fri, 13 Sep 2002 22:30:16 +0200
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020828
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Booth <neil@daikokuya.co.uk>
CC: Thunder from the hill <thunder@lightweight.ods.org>, dag@brattli.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.34: IR __FUNCTION__ breakage
References: <Pine.LNX.4.44.0209121414570.10048-100000@hawkeye.luckynet.adm> <3D820BC9.5080207@domdv.de> <20020913201258.GA11481@daikokuya.co.uk>
X-Enigmail-Version: 0.65.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Booth wrote:
> Andreas Steinmetz wrote:-
> 
> 
>>At least for gcc 3.2 this would be better:
>>
>>#define DERROR(dbg, fmt, args...) \
>>    do { if (DEBUG_##dbg) \
>>        printk(KERN_INFO "irnet: %s(): " fmt, __FUNCTION__, ##args); \
>>    } while(0)
>>
>>Unfortunately this doesn't work with gcc 2.95.3.
> 
> 
> I think it might if you put a space after __FUNCTION__ and before the
> comma.
> 
> Neil.
> 

Yes, I just verified it does work this way on gcc 2.95.3 though in my 
opinion it is very prone to errors (typos, ...). Furthermore I don't 
have any older compilers around for testing this which might still be in 
use.

-- 
Andreas Steinmetz
D.O.M. Datenverarbeitung GmbH

