Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279505AbRKASfC>; Thu, 1 Nov 2001 13:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279509AbRKASex>; Thu, 1 Nov 2001 13:34:53 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:28535 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S279505AbRKASes>; Thu, 1 Nov 2001 13:34:48 -0500
Date: Thu, 1 Nov 2001 13:34:41 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: vda <vda@port.imtp.ilyichevsk.odessa.ua>,
        Tim Schmielau <tim@physik3.uni-rostock.de>,
        Andreas Dilger <adilger@turbolabs.com>, linux-kernel@vger.kernel.org,
        J Sloan <jjs@lexus.com>
Subject: Re: [Patch] Re: Nasty suprise with uptime
Message-ID: <20011101133441.E11773@redhat.com>
In-Reply-To: <20011101120222.B11773@redhat.com> <Pine.LNX.3.95.1011101125206.1496A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.3.95.1011101125206.1496A-100000@chaos.analogic.com>; from root@chaos.analogic.com on Thu, Nov 01, 2001 at 01:03:32PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2001 at 01:03:32PM -0500, Richard B. Johnson wrote:
> does the jumps on condition and tests for zero, even after the
> flags have been set by the previous operation, I tested what
> the result was. It turns out that it's only a couple of clock
> cycles, not the 6 extra clocks that the hand calculation shows.

*sigh*  You're not testing any of the effects on available execution 
resources within the processor.

> So, if you leave jiffies alone, but bump another variable when it
> wraps, you get to eat your cake and keep it too.

As Linus pointed out, using casting tricks with a long long will just 
work for this case.  Sounds good to me.

		-ben
