Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316857AbSF0OYq>; Thu, 27 Jun 2002 10:24:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316860AbSF0OYp>; Thu, 27 Jun 2002 10:24:45 -0400
Received: from terminus.zytor.com ([64.158.222.227]:2689 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S316857AbSF0OYo>; Thu, 27 Jun 2002 10:24:44 -0400
Message-ID: <3D1B200B.5040202@zytor.com>
Date: Thu, 27 Jun 2002 10:24:11 -0400
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0rc1) Gecko/20020425
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davidm@hpl.hp.com
CC: Andreas Schwab <schwab@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.24: auto_fs.h typo.
References: <200206251759.34690.schwidefsky@de.ibm.com>	<afb4im$6nl$1@cesium.transmeta.com>	<je7kkm8bma.fsf@sykes.suse.de>	<3D19CE5E.1090704@zytor.com> <15642.36216.782111.506354@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Mosberger wrote:
>>>>>>On Wed, 26 Jun 2002 10:23:26 -0400, "H. Peter Anvin" <hpa@zytor.com> said:
>>>>>
> 
>   hpa> Andreas Schwab wrote:
>   >> |> |> Please change this to:
>   >> |> 
>   >> |> #ifndef __alpha__
>   >> 
>   >> What about __ia64__?
> 
>   hpa> Oh right, that one too...
> 
> Isn't this the one which we agreed not to change because it would break
> existing ia64 automount binaries and because we do not expect x86 automount
> to run on ia64 machines?
> 

Right, hence:

#if !defined(__alpha__) && !defined(__ia64__)

Alpha and IA64 being the 64-bit architectures which will continue to use 
the older interface.

	-hpa




