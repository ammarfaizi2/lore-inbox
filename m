Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317997AbSHDRHD>; Sun, 4 Aug 2002 13:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318162AbSHDRHD>; Sun, 4 Aug 2002 13:07:03 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:1529 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317997AbSHDRHC>; Sun, 4 Aug 2002 13:07:02 -0400
Subject: Re: 2.4.19 IDE Partition Check issue
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: alien.ant@ntlworld.com
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <3D4D5DCB.88F1484E@ntlworld.com>
References: <20020804054239.62923.qmail@web9203.mail.yahoo.com>
	<1028470037.14195.24.camel@irongate.swansea.linux.org.uk> 
	<3D4D4544.4045B5D3@ntlworld.com>
	<1028480553.14195.35.camel@irongate.swansea.linux.org.uk> 
	<3D4D5DCB.88F1484E@ntlworld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Aug 2002 19:28:54 +0100
Message-Id: <1028485734.14196.45.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-08-04 at 18:00, alien.ant@ntlworld.com wrote:
> > The ALi hang may well be sort of this. If its what Andre thinks then its
> > lack of support for LBA48 on ALi interface hardware (or at least for the
> > documentation we currently have on how to program it). If so -ac2 should
> > sort that one out
> 
> In my case I'm using a Highpoint and not an ALi controller. People also
> seem to experience the same problem with Promise, ALi and Highpoint
> controllers on the 2.4.19-pre kernels so it looks unlikely to be a
> controller spei

The Promise stuff is fixed in -ac and was exactly this issue. LBA48 is
not supported by the earlier promise controllers. The highpoint may well
be the same problem.

