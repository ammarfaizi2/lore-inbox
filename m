Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129466AbQKFRXE>; Mon, 6 Nov 2000 12:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbQKFRWy>; Mon, 6 Nov 2000 12:22:54 -0500
Received: from [212.150.182.35] ([212.150.182.35]:25619 "EHLO
	exchange.guidelet.com") by vger.kernel.org with ESMTP
	id <S129200AbQKFRWi>; Mon, 6 Nov 2000 12:22:38 -0500
Message-ID: <03da01c04816$8b178a30$650201c0@guidelet>
From: "Alon Ziv" <alonz@usa.net>
To: "David Woodhouse" <dwmw2@infradead.org>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <200011061631.eA6GVkw07051@pincoya.inf.utfsm.cl>  <6590.973530406@redhat.com>
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
Date: Mon, 6 Nov 2000 19:25:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.3018.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The best solution to the sound driver issue, IMHO, is still entirely
userspace---
just no-one has written it yet.
What we should do:
1. Before auto-unload of the driver, run a small utility which will read
mixer settings
   and save them somewhere
2. When auto-loading the driver, use driver arguments which are initialized
from the
   settings saved above
All that's missing is the method of passing data from step 1 to step 2.

----- Original Message -----
From: "David Woodhouse" <dwmw2@infradead.org>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Cc: <linux-kernel@vger.kernel.org>
Sent: Monday, November 06, 2000 19:06
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page]


>
> vonbrand@inf.utfsm.cl said:
> >  No funny "persistent data" mechanisms or screwups when the worker
> > gets removed and reinserted. In many cases the data module could be
> > shared among several others, in other cases it would have to be able
> > lo load several times or manage several incarnations of its payload.
>
> The reason I brought this up now is because Keith's new
> inter_module_register stuff could easily be used to provide this
> functionality _without_ the extra module remaining loaded.
>
>
> --
> dwmw2
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
