Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261614AbTCaLvJ>; Mon, 31 Mar 2003 06:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261618AbTCaLvJ>; Mon, 31 Mar 2003 06:51:09 -0500
Received: from mail.iwr.uni-heidelberg.de ([129.206.104.30]:46553 "EHLO
	mail.iwr.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id <S261614AbTCaLvH>; Mon, 31 Mar 2003 06:51:07 -0500
Date: Mon, 31 Mar 2003 14:02:20 +0200 (CEST)
From: Bogdan Costescu <bogdan.costescu@iwr.uni-heidelberg.de>
To: Andrew Morton <akpm@digeo.com>
cc: "J.A. Magallon" <jamagallon@able.es>, <linux-kernel@vger.kernel.org>,
       <marcelo@conectiva.com.br>, <vortex@scyld.com>
Subject: Re: [vortex] Re: Bad PCI IDs-Names table in 3c59x.c
In-Reply-To: <20030329131218.04a8cf1e.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303311359240.22108-100000@kenzo.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Mar 2003, Andrew Morton wrote:

> Nope, Donald's latest driver has
>     {"3c982 Server Tornado",{ 0x980510B7, 0xffffffff },
>      PCI_IOTYPE, CYCLONE_SIZE, FEATURE_TORNADO, },
> (Note: no HAS_NWAY either)

You missed something above that:

#define FEATURE_TORNADO  (IS_TORNADO|HAS_NWAY|HAS_V2_TX) /* 905C */

> hm, the 2.5 kernel has 
>     {"3c980C Python-T",
>      PCI_USES_IO|PCI_USES_MASTER, IS_CYCLONE|HAS_NWAY|HAS_HWCKSM, 128, },
> for 10b7/9805, which looks much more healthy.

But I would argue that this should have IS_CYCLONE replaced by IS_TORNADO. 
Not that it makes much difference though, as they are not used much in the 
code ;-)

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De

