Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbWAIFwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWAIFwQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 00:52:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbWAIFwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 00:52:16 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:14719 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750749AbWAIFwP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 00:52:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kvWpuBWlt/nx/+pAFqmNMyZ5G+nMjo2L/4xisjbb4OEysS5cOPE7Muq7e9pI6ewzvECacO2GRVe2UE6w2PaLwlLl0/J2wF6YmTSEimxDcRiywiG9hUdY1bSJuiwYdQngPKrLbbMOm7PQ6V1KCptRmZlhQV6PXyedymfGkUSrMPc=
Message-ID: <f69849430601082152v311c1350p3db663e5eadb8ae7@mail.gmail.com>
Date: Sun, 8 Jan 2006 21:52:14 -0800
From: kernel coder <lhrkernelcoder@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: Almost 80% of UDP packets dropped
In-Reply-To: <20060107224455.GD9197@irc.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f69849430601062303n331ab0aaue8635f69d75d8510@mail.gmail.com>
	 <200601071704.52833.vda@ilport.com.ua> <20060107152325.GC9197@irc.pl>
	 <Pine.LNX.4.61.0601072219480.8085@yvahk01.tjqt.qr>
	 <20060107224455.GD9197@irc.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all your help.Ethernet driver is already using NAPI.

The main problem was that the sender was running on P4 which has 3 gHz
speed and the reciever had speed 133MHz.So the sender was transmitting
packets far quicker than the reciever could handle.

Then i used the sme MIPS board as transmitter and another one as
receiver so now i recieved almost 80% of transmitted file.

shahzad

On 1/7/06, Tomasz Torcz <zdzichu@irc.pl> wrote:
> On Sat, Jan 07, 2006 at 10:19:56PM +0100, Jan Engelhardt wrote:
> >
> > >> Use TCP instead.
> > >
> > > Or DCCP.
> >
> > Don't you mean SCTP?
>
>  No, DCCP, UDP-like protocol with TCP-like congestion control. In
> mainline kernel since 2.6.14. DCCPv6 in the works.
> http://www.wlug.org.nz/DCCP   http://lwn.net/Articles/149756/
>
> --
> Tomasz Torcz                 "God, root, what's the difference?"
> zdzichu@irc.-nie.spam-.pl         "God is more forgiving."
>
>
>
>
