Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265718AbSKAT6G>; Fri, 1 Nov 2002 14:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265726AbSKAT6G>; Fri, 1 Nov 2002 14:58:06 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:36616 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S265718AbSKAT6B>;
	Fri, 1 Nov 2002 14:58:01 -0500
Date: Fri, 1 Nov 2002 21:00:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Pawel Kot <pkot@bezsensu.pl>, Rusty Russell <rusty@rustcorp.com.au>,
       Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
       Anton Altaparmakov <aia21@cantab.net>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.45: NTFS unresolved symbol
Message-ID: <20021101200042.GB1832@mars.ravnborg.org>
Mail-Followup-To: Andrew Morton <akpm@digeo.com>,
	Pawel Kot <pkot@bezsensu.pl>, Rusty Russell <rusty@rustcorp.com.au>,
	Dieter =?iso-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
	Anton Altaparmakov <aia21@cantab.net>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <200211010431.00941.Dieter.Nuetzel@hamburg.de> <Pine.LNX.4.33.0211011318270.5622-100000@urtica.linuxnews.pl> <3DC2DAA0.A46C5085@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC2DAA0.A46C5085@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2002 at 11:48:48AM -0800, Andrew Morton wrote:
> We have these magical symbols which describe the offset of
> a member of the per-cpu storage, which need to be exposed
> to modules.  So I added an EXPORT_PER_CPU_SYMBOL() helper:
> 
> #define EXPORT_PER_CPU_SYMBOL(var) EXPORT_SYMBOL(var##__per_cpu)
> #define EXPORT_PER_CPU_SYMBOL_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)

I would expect the following to work:
#define EXPORT_SYMBOL_PER_CPU(var) EXPORT_SYMBOL(var##__per_cpu)
#define EXPORT_SYMBOL_PER_CPU_GPL(var) EXPORT_SYMBOL_GPL(var##__per_cpu)

In this case the magic "EXPORT_SYMBOL" is still present.

	Sam
