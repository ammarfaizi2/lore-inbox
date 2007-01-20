Return-Path: <linux-kernel-owner+w=401wt.eu-S965381AbXATUpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965381AbXATUpY (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965385AbXATUpY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:45:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:3654 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965381AbXATUpX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:45:23 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EBfiiOOEAtbTOrQ8ZtWqeOa+pPH6ulVxF9Fb4MsexYV2bowaLSXbT2Re3cezcz3HO5k+TPorXe1M3gSiXTD8nCitWRPdNWHB0v5txXw0dv3z5Y1OR+3Mp/z4hRUUkd9F0ielpVTzsKuh7PTpasqd+pXy68nhVdM9ZWXz7HroHjs=
Message-ID: <3aa654a40701201245s72b2f76hc70ddd94b70ba99c@mail.gmail.com>
Date: Sat, 20 Jan 2007 12:45:21 -0800
From: "Avuton Olrich" <avuton@gmail.com>
To: "Justin Piszcz" <jpiszcz@lucidpixels.com>
Subject: Re: 2.6.19.2, cp 18gb_file 18gb_file.2 = OOM killer, 100% reproducible
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <Pine.LNX.4.64.0701201516450.3684@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701201516450.3684@p34.internal.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/07, Justin Piszcz <jpiszcz@lucidpixels.com> wrote:
> Perhaps its time to back to a stable (2.6.17.13 kernel)?
>
> Anyway, when I run a cp 18gb_file 18gb_file.2 on a dual raptor sw raid1
> partition, the OOM killer goes into effect and kills almost all my
> processes.
>
> Completely 100% reproducible.
>
> Does 2.6.19.2 have some of memory allocation bug as well?

I had been seeing something similar (also with 2.6.19.2), but it's not
outputting anything to dmesg, so I was waiting for something to happen
before I reported it. It's mostly the same thing, but I've only seen
it happen when copying something large (2+ GB) over NFS. Interactivity
completely goes away and lockups last 10-15 seconds a piece. Then
realized I turned the swap off, so I turned it on and didn't lockup
any longer.
-- 
avuton
--
 Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
