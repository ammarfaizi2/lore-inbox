Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312462AbSCUTQx>; Thu, 21 Mar 2002 14:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312460AbSCUTQo>; Thu, 21 Mar 2002 14:16:44 -0500
Received: from twilight.cs.hut.fi ([130.233.40.5]:64446 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S312458AbSCUTQe>; Thu, 21 Mar 2002 14:16:34 -0500
Date: Thu, 21 Mar 2002 21:16:12 +0200
From: Ville Herva <vherva@niksula.hut.fi>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Adam Kropelin <akropel1@rochester.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre3-ac4
Message-ID: <20020321191612.GH174986@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	"J.A. Magallon" <jamagallon@able.es>,
	Adam Kropelin <akropel1@rochester.rr.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E16nje1-0002oN-00@the-village.bc.nu> <006101c1d084$275029b0$02c8a8c0@kroptech.com> <20020321152852.GA2028@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 04:28:52PM +0100, you [J.A. Magallon] wrote:
> 
> On 2002.03.21 Adam Kropelin wrote:
>
> >> o The incredible shrinking kernel patch (Andrew Morton)
> >
> >Is there a magic incantation I need in order to see an improvement from this?
> >I'm observing a slight (< 10 KB) increase from -ac3 to -ac4. Same .config, same
> >compiler.
> >
> >I only build 2 modules; everything else is static. Perhaps Andrew's fix is for
> >heavy module users?
> >
> 
> I think it gives about 100k size decrease IFF you have verbose BUG activated.

See
http://marc.theaimsgroup.com/?l=linux-kernel&m=101663081100880&w=2
Subject: [patch] smaller kernels

and
http://marc.theaimsgroup.com/?l=linux-kernel&m=101663080500800&w=2
[patch] x86 BUG handling

Of the latter, Andrew says: "kernel size is reduced by 90 kbytes
relative to a CONFIG_DEBUG_BUGVERBOSE=y build" and of the former: "Kernel
size is reduced by another 110 kbytes in my build."

The former is a duplicate string removal patch, and gcc >= 3 does most of
that automatically, so you won't see the much difference. The latter only
reduces kernel size compared to BUG_VERBOSE=y (and may slightly increase the
size compared the BUG_VERBOSE=n).


-- v --

v@iki.fi
