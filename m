Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315414AbSE2O0t>; Wed, 29 May 2002 10:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315416AbSE2O0s>; Wed, 29 May 2002 10:26:48 -0400
Received: from sm14.texas.rr.com ([24.93.35.41]:38796 "EHLO sm14.texas.rr.com")
	by vger.kernel.org with ESMTP id <S315414AbSE2O0q>;
	Wed, 29 May 2002 10:26:46 -0400
Subject: Re: [PATCH] 2.5.18 IDE 73
From: Gerald Champagne <gerald@io.com>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CF4D19F.9080402@evision-ventures.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 29 May 2002 09:26:42 -0500
Message-Id: <1022682402.2951.33.camel@wiley>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Dear Gerald please look closer. The hdparm -i is executing the
> drive id command directly and does *not* rely on the internally
> permanently dragged around id structure. So the change I did
> is entierly fine. Just go ahead and check whatever hdparm -i /dev/hdx
> reports the proper thing after changing some dma setting.
> It does - I did check it :-).

Ah, sorry about that.  I missed that in your patch.  The previous
version of the ioctl just returned copied the values from the id
structure.  Doing the id on the fly is much more accurate and will catch
any other fields that happen to change over time.  

> BTW> The next thing to be gone is simple the fact that we drag
> around the id information permanently, where infact only
> some capabilitie fields are sucked out of it and the
> device identification string is only needed for reporting
> during boot-up.

That sounds good.  That would make it easier to see what values from the
id are actually used.

Thanks.

Gerald


