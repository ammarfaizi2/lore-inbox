Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293705AbSCUJTP>; Thu, 21 Mar 2002 04:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293712AbSCUJTG>; Thu, 21 Mar 2002 04:19:06 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5392 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293705AbSCUJS6>;
	Thu, 21 Mar 2002 04:18:58 -0500
Message-ID: <3C99A54D.1050206@mandrakesoft.com>
Date: Thu, 21 Mar 2002 04:18:05 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
CC: Axel Kittenberger <Axel.Kittenberger@maxxio.at>,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Patch, forward release() return values to the close() call
In-Reply-To: <200203210747.IAA25949@merlin.gams.co.at> <3C99997C.6030202@mandrakesoft.com> <16nyaE-1ala7MC@fmrl01.sul.t-online.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:

>On Thursday 21 March 2002 09:27, Jeff Garzik wrote:
>
>>Whoops, my apologies.  The patch looks ok to me.
>>
>>I read your text closely and the patch not close enough.  As I said, it
>>is indeed wrong for a device driver to fail f_op->release(), "fail"
>>being defined as leaving fd state lying around, assuming that the system
>>will fail the fput().
>>
>>But your patch merely propagates a return value, not change behavior,
>>which seems sane to me.
>>
>
>Hi,
>
>close() does not directly map to release().
>If you want your device to return error
>information reliably, you need to implement flush().
>

Agreed.

I still think propagating f_op->release's return value is a good idea, 
though.

    Jeff



