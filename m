Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261786AbSI3NEN>; Mon, 30 Sep 2002 09:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261790AbSI3NEN>; Mon, 30 Sep 2002 09:04:13 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:64762 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261786AbSI3NEM>; Mon, 30 Sep 2002 09:04:12 -0400
Subject: Re: 2.3.39 compile errors on Alpha
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: bunk@fs.tum.de, jochen@scram.de, linux-kernel@vger.kernel.org
In-Reply-To: <20020930.052555.123500588.davem@redhat.com>
References: <Pine.NEB.4.44.0209301257210.12605-100000@mimas.fachschaften.tu-muenchen.de>
	 <1033389340.16337.14.camel@irongate.swansea.linux.org.uk> 
	<20020930.052555.123500588.davem@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 30 Sep 2002 14:15:50 +0100
Message-Id: <1033391751.16468.51.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-30 at 13:25, David S. Miller wrote:
>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 30 Sep 2002 13:35:40 +0100
> 
>    Is this actually safe - suppose the machine has no tsc counter (eg old
>    x86 or indeed new x86 numa, speedstep using, etc). In that case
>    do_gettimeofday doesn't appear to be either IRQ safe or fast enough to
>    use in this way ?
> 
> This is how netif_rx() has worked for a long time.  ATM is just
> copying the input packet logic.
> 
> So why are you complaining now? :-)

Because I was looking over the gettimeoffset code and forgot that
gettimeofday itself takes the xtime_lock 8)

Alan


