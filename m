Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262953AbTCKPm5>; Tue, 11 Mar 2003 10:42:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262955AbTCKPm5>; Tue, 11 Mar 2003 10:42:57 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:40126
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262953AbTCKPmz>; Tue, 11 Mar 2003 10:42:55 -0500
Subject: Re: 2.5.63 accesses below %esp (was: Re: ntfs OOPS (2.5.63))
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.30.0303100723300.2790-100000@divine.city.tvnet.hu>
References: <Pine.LNX.4.30.0303100723300.2790-100000@divine.city.tvnet.hu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1047402060.19262.33.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 11 Mar 2003 17:01:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-10 at 07:22, Szakacsits Szabolcs wrote:
> The question is if we want to support the buggy 2.9[56] compilers or
> not. I checked Red Hat 7.3 and the latest errata gcc fixes this issue,
> the generated code is ok. But your complier didn't and probably many
> more out there don't.

I don't think gcc 2.96 had that problem. I've not seen it there, but 
gcc 3.0.x certainly does and a gcc 3.0.x early 3.1.x built kernels seems
to explode randomly under load probably for this reason.

I've also not seen any problemd with this on gcc 3.2. Valgrind has some
notes on affected compilers as the valgrind app also picks up this
violation by the compiler.

