Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTE2JsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 05:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262073AbTE2JsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 05:48:07 -0400
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:3763 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id S262063AbTE2JsG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 05:48:06 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
Date: Thu, 29 May 2003 20:02:34 +1000
User-Agent: KMail/1.5.1
References: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.55L.0305282019160.321@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200305292002.34494.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 May 2003 10:55, Marcelo Tosatti wrote:
> Hi,
>
> Here goes -rc6. I've decided to delay 2.4.21 a bit and try Andrew's fix
> for the IO stalls/deadlocks.
>
> Please test it.
>
>

> Andrew Morton <akpm@digeo.com>:
>   o Fix IO stalls and deadlocks

As this is only patches 1 and 2 from akpm's suggested changes I was wondering 
if my report got lost in the huge thread so I've included it here:

Ok patch combination final score for me is as follows in the presence of a 
large continuous write:
1 No change
2 No change
3 improvement++; minor hangs with reads
1+2 improvement+++; minor pauses with switching applications
1+2+3 improvement++++; no pauses

Applications may start up slowly that's fine. The mouse cursor keeps spinning 
and responding at all times though with 1+2+3 which it hasn't done in 2.4 for 
a year or so.

Is there a reason the 3rd patch was omitted?

Con
