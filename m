Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318340AbSGYIEu>; Thu, 25 Jul 2002 04:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318365AbSGYIEt>; Thu, 25 Jul 2002 04:04:49 -0400
Received: from zeus.kernel.org ([204.152.189.113]:32701 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S318340AbSGYIEs>;
	Thu, 25 Jul 2002 04:04:48 -0400
Message-ID: <3D3FB062.90204@evision.ag>
Date: Thu, 25 Jul 2002 10:01:38 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC/CFT] cmd640 irqlocking fixes
References: <20020724225826.GF25038@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> I don't have one of these, and I'm not even sure what it is. But here's
> a wild guess at a fix.
> 
> 
> Cheers,
> Bill
> ===== drivers/ide/cmd640.c 1.11 vs edited =====
> --- 1.11/drivers/ide/cmd640.c	Wed May 22 04:21:11 2002
> +++ edited/drivers/ide/cmd640.c	Wed Jul 24 18:51:54 2002
> @@ -115,6 +115,12 @@
>  #include "ata-timing.h"
>  
>  /*
> + * Is this remotely correct?
> + */

The proper fix (rating: 50% propability of beeing perfect and 99.99% 
propability of working) is just to *remove* those georgeous IRQ
"tooglers" *alltogether*. Scrap them... becouse I don't see how any
of the encolosed commands could cause an IRQ...

