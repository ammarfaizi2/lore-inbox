Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263109AbREWOlz>; Wed, 23 May 2001 10:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263108AbREWOlp>; Wed, 23 May 2001 10:41:45 -0400
Received: from ns.suse.de ([213.95.15.193]:52495 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S263107AbREWOlb>;
	Wed, 23 May 2001 10:41:31 -0400
Date: Wed, 23 May 2001 16:40:36 +0200
From: Andi Kleen <ak@suse.de>
To: =?iso-8859-1?Q?christophe_barb=E9?= <christophe.barbe@lineo.fr>
Cc: Andi Kleen <ak@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: sk_buff destructor in 2.2.18
Message-ID: <20010523164036.A24809@gruyere.muc.suse.de>
In-Reply-To: <20010523161654.C7531@pc8.lineo.fr> <20010523162739.A24463@gruyere.muc.suse.de> <20010523163758.C7823@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010523163758.C7823@pc8.lineo.fr>; from christophe.barbe@lineo.fr on Wed, May 23, 2001 at 04:37:58PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2001 at 04:37:58PM +0200, christophe barbé wrote:
> It seems to not be the case, because my destructor is called.

It is called, but you overwrote the kernel destructor and therefore
broke the socket memory accounting completely; causing all kinds of 
problems.

> Could you point me the code where you think this method is already used?

net/core/sock.c


-Andi

