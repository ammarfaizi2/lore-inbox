Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262796AbSKTVqp>; Wed, 20 Nov 2002 16:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSKTVqp>; Wed, 20 Nov 2002 16:46:45 -0500
Received: from ns.ithnet.com ([217.64.64.10]:5134 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262796AbSKTVqo>;
	Wed, 20 Nov 2002 16:46:44 -0500
Date: Wed, 20 Nov 2002 22:53:36 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: gallir@uib.es, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: PATCH: Recognize Tualatin cache size in 2.4.x
Message-Id: <20021120225336.4e5beac6.skraw@ithnet.com>
In-Reply-To: <20021120214104.GA21030@suse.de>
References: <200211171549.gAHFnSrE021923@mnm.uib.es>
	<20021118190200.GA20936@suse.de>
	<200211182154.52081.gallir@uib.es>
	<20021119120834.GA32004@suse.de>
	<20021120210357.70464ff2.skraw@ithnet.com>
	<20021120214104.GA21030@suse.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Nov 2002 21:41:04 +0000
Dave Jones <davej@codemonkey.org.uk> wrote:

> On Wed, Nov 20, 2002 at 09:03:57PM +0100, Stephan von Krawczynski wrote:
>  > On Tue, 19 Nov 2002 12:08:34 +0000
>  > Dave Jones <davej@codemonkey.org.uk> wrote:
>  > 
>  > > On Mon, Nov 18, 2002 at 09:54:52PM +0100, Ricardo Galli wrote:
>  > > 
>  > >  > It's very cosmetic but very annoying for P3 > 1GHz, where Linux <= 2.4.20-preX 
>  > >  > only reports 32 KB of cache and it also seems to ignore the "cachesize" 
>  > >  > parameter. Perhaps it really uses 256KB, but not sure.
>  > > 
>  > > There was a bug related to that parameter, I'm sure if the fix
>  > > went into the same patch, or a separate one. I'll check later.
>  > 
>  > Sorry for this possibly dumb comment/question:
>  > my Tualatins have 512KB cache on die. Are we all sure that it's used?
>  > /proc says indeed 32KB on 2.4.20-rc2
> 
> Odd. If you can send me the output of dmesg, /proc/cpuinfo
> and x86info -a, I'll take a look.
> (You can find x86info at
>  http://www.codemonkey.org.uk/x86info/x86info-1.11.tar.gz)

Hi Dave,

I just tested your descriptors.diff, and here are the results:
(make dep clean bzImage modules modules_install, all same tree of course)

2.4.20-rc2:
real  5m27.670s   user  5m6.450s   sys  0m18.710s
real  5m27.590s   user  5m6.760s   sys  0m18.660s
real  5m27.953s   user  5m6.900s   sys  0m18.310s

2.4.20-rc2 with descriptors.diff:

real  5m29.005s   user  5m8.540s   sys  0m18.610s
real  5m27.752s   user  5m8.760s   sys  0m17.870s
real  5m29.021s   user  5m8.210s   sys  0m18.540s

Doesn't really look more than cosmetic, does it?
/proc output is correct with your diff.

Regards,
Stephan

