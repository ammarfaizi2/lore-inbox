Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262425AbUCaUQh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 15:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUCaUQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 15:16:37 -0500
Received: from pop.gmx.net ([213.165.64.20]:51330 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262425AbUCaUQf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 15:16:35 -0500
X-Authenticated: #1045983
From: Helge Deller <deller@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 on Itanium2: floating-point assist fault at ip 400000000062ada1, isr 0000020000000008
Date: Wed, 31 Mar 2004 22:15:52 +0200
User-Agent: KMail/1.6.51
Cc: ulrich.windl@rz.uni-regensburg.de
References: <406AE0D5.10359.1930261@localhost> <200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200403311900.17293.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403312215.52635.deller@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 31 March 2004 19:00, Denis Vlasenko wrote:
> On Wednesday 31 March 2004 15:16, Ulrich Windl wrote:
> > Hello,
> >
> > I did try to find an answer is SuSE's support database, not in SAP's
> > support database, and also did search Google, but could not find an answer:
> >
> > We run SuSE Linux Enterprise Server 8 (SLES8) on a HP rx4640 Itanium2
> > server with 2 CPUs (family: Itanium 2, model: 1, revision: 5, archrev: 0).
> >
> > In syslog is do see periodic kernel messages (with no implicit priority)
> > that read:
> >
> > dw.sapC11_DVS02(14393): floating-point assist fault at ip 400000000062ada1,
> > isr 0000020000000008
> >
> > ("dw.sapC11_DVS02" is a SAP R/3 work process (46D_EXT, patch 1754, for
> > those who care)
> >
> > Can anybody explain what this message means? Is it an application problem,
> > or is it a kernel problem?
> 
>....
>
> kernel says that you have them too frequently, which probably
> impairs efficiency. It's a hint to programmer.

Correct.
We are aware of this message and it will be fixed with a future SAP R/3 kernel patch.
Since this message is only raised in the startup code of the R/3 kernel you shouldn't 
see any runtime performance impact and can safely ignore the message for now.

Helge Deller
SAP LinuxLab
