Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263122AbREWPJP>; Wed, 23 May 2001 11:09:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263124AbREWPJF>; Wed, 23 May 2001 11:09:05 -0400
Received: from ns.suse.de ([213.95.15.193]:49938 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263122AbREWPIz>;
	Wed, 23 May 2001 11:08:55 -0400
Date: Wed, 23 May 2001 17:08:00 +0200
From: Andi Kleen <ak@suse.de>
To: =?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sk_buff destructor in 2.2.18
Message-ID: <20010523170800.A25573@gruyere.muc.suse.de>
In-Reply-To: <20010523161654.C7531@pc8.lineo.fr> <20010523162739.A24463@gruyere.muc.suse.de> <20010523163758.C7823@pc8.lineo.fr> <20010523164036.A24809@gruyere.muc.suse.de> <20010523165028.A7917@pc8.lineo.fr> <20010523165557.A25277@gruyere.muc.suse.de> <20010523170215.C8075@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010523170215.C8075@pc8.lineo.fr>; from christophe.barbe@lineo.fr on Wed, May 23, 2001 at 05:02:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 05:02:15PM +0200, christophe barbé wrote:
> I believe you and It's sure that I have not tested all cases.
> So do you see a way to use a private data buffer ?

The only way I know currently is to keep skb->users >= 1 and use a timer
that collects such buffers from a global list, but it is not very nice. The
stack doesn't like private buffers.

-Andi
