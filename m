Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbTAKPg3>; Sat, 11 Jan 2003 10:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267257AbTAKPg3>; Sat, 11 Jan 2003 10:36:29 -0500
Received: from smtp-101.nerim.net ([62.4.16.101]:26634 "EHLO kraid.nerim.net")
	by vger.kernel.org with ESMTP id <S267248AbTAKPg2>;
	Sat, 11 Jan 2003 10:36:28 -0500
Message-ID: <3E203C00.5060403@inet6.fr>
Date: Sat, 11 Jan 2003 16:45:04 +0100
From: Lionel Bouton <Lionel.Bouton@inet6.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: choice of raid5 checksumming algorithm wrong ?
References: <1042266405.14440.54.camel@sun>
In-Reply-To: <1042266405.14440.54.camel@sun>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg wrote:

>Hi!
>
>I really do wonder whether the displayed message is wrong or why it
>always chooses the slowest checksumming function (happens with 2.4.19 -
>21pre3)
>  
>
SSE is always preferred because unlike other checksumming code it 
doesn't use the processor caches when reading/writing data/checksum.
This is slower (if several GB/s can be considered slow) for the 
checksumming but far better for the overall system performance.

LB.

