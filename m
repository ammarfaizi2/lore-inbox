Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750705AbWEHUkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWEHUkS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 16:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWEHUkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 16:40:18 -0400
Received: from mtiwmhc12.worldnet.att.net ([204.127.131.116]:13244 "EHLO
	mtiwmhc12.worldnet.att.net") by vger.kernel.org with ESMTP
	id S1750705AbWEHUkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 16:40:17 -0400
Message-ID: <445FACA3.5040204@lwfinger.net>
Date: Mon, 08 May 2006 15:40:03 -0500
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: Compile error for 2.6.17-rc3-git15
References: <445FA8CF.9080405@lwfinger.net> <20060508203000.GC5467@mars.ravnborg.org>
In-Reply-To: <20060508203000.GC5467@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Mon, May 08, 2006 at 03:23:43PM -0500, Larry Finger wrote:
>> After updating to 2.6.17-rc3-git15 
>> (6810b548b25114607e0814612d84125abccc0a4f) and using gcc V4.0.2, I get the 
>> following compile error:
>>
>> HOSTCC  scripts/mod/modpost.o
>> scripts/mod/modpost.c: In function ?check_sec_ref?:
>> scripts/mod/modpost.c:716: error: cast to union type from type not present 
>> in union
>>
>> Using git bisect, I find that bed7a560333d40269a886c4421d4c8f964a32177 is 
>> first bad commit.
> The above is the merge of the kbuild changes.
> The real offender is: c8d8b837ebe4b4f11e1b0c4a2bdc358c697692ed
> 
> Reverting this will fix it.
> 

Right on.  Thanks.

Larry
