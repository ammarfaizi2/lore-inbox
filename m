Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316239AbSEZSMa>; Sun, 26 May 2002 14:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316241AbSEZSM3>; Sun, 26 May 2002 14:12:29 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:47602 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316239AbSEZSM2>; Sun, 26 May 2002 14:12:28 -0400
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1
	-march=pentium{-mmx,3,4}
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020526091108.GA1749@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 May 2002 20:14:32 +0100
Message-Id: <1022440472.11859.117.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-05-26 at 10:11, J.A. Magallon wrote:
> >Splitting PII from PPro is a good move for another reason. The PPro
> >requires a locked spin_unlock due to an errata - the PII seems not to. 
> >
> 
> So I can kill CONFIG_X86_PPRO_FENCE for a PII ? If yes, I will try.

As I understand the errata involved yes you can. If so please make sure
the  PII specific kernel panics on a ppro because subtle locking failure
is not a pleasant result when someone runs the wrong kernel.

PII specific also means you can assume MMX is present which may be
useful in future page copying accelerations

