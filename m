Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316444AbSEaW40>; Fri, 31 May 2002 18:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316964AbSEaW4Z>; Fri, 31 May 2002 18:56:25 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:51183 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316444AbSEaW4Y>; Fri, 31 May 2002 18:56:24 -0400
Subject: Re: linux-2.4.19-pre9-ac3: PnPBIOS crash
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chris Rankin <cj.rankin@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200205312208.g4VM8unD001714@twopit.underworld>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 01 Jun 2002 01:00:47 +0100
Message-Id: <1022889647.20348.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-05-31 at 23:08, Chris Rankin wrote:
> I have a dual PIII machine with 1.25 GB of RAM, and I have just
> installed a 2.4.19-pre9-ac3 kernel. (I also have ALSA CVS and lm
> sensors 2.6.3 installed.)
> 
> Anyway, I decided to compile in the PNPBIOS feature and discovered
> that:
> 
> # cat /proc/bus/pnp/escd
> 
> is a synonym for "cold reboot". Now I understand that *writing* to
> random /proc files is a Bad Thing, but reading them??? I would have
> thought that the worst I could have done would have been corrupting my
> termininal. Is the escd file my actual ESCD area?
> 
> Is this a bug, or just a case of "don't do that!"?

Could be either. It should dump the ESCD by asking the BIOS for it. It
could be there is a case we are calling wrong, could be a BIOS bug where
the BIOS can't handle BIOS32 ESCD

Alan

