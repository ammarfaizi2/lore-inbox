Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262597AbSJEU70>; Sat, 5 Oct 2002 16:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262601AbSJEU70>; Sat, 5 Oct 2002 16:59:26 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:31986 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262597AbSJEU7Z>; Sat, 5 Oct 2002 16:59:25 -0400
Subject: Re: [PATCH 2.2] i386/dmi_scan updates
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021005201723.A1FA062D01@mallaury.noc.nerim.net>
References: <20021005201723.A1FA062D01@mallaury.noc.nerim.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 22:13:55 +0100
Message-Id: <1033852435.4441.19.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 23:19, Jean Delvare wrote:
> This check has been removed in 2.4 though. I think it was needed when we were 
> trusting the structure count (see version 1.1 of dmidecode) instead of
> also verifying we weren't running of the table. Now that this check is
> done, I don't see why we would need the heuristic anymore.

True - btw word wrap is broken on your mailer

> Also note that the white spaces check has been removed from 2.4.

The debug data can basically go

> A better way IMHO would be to "secure" the dmi_string function. If we can 
ensure it will always return a safe (that is, null terminated) string, we are done. Agreed?

I'd ascii filter it as well but yes. The length one I dont think is a
problem because the table length will gie us a defined worst case

