Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWABWDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWABWDM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 17:03:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWABWDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 17:03:12 -0500
Received: from nproxy.gmail.com ([64.233.182.195]:31189 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751082AbWABWDL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 17:03:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eqxyh9RWGBawcGGusJmuD1hrdWpyB/TvUc5ME+3CFlk27CtdWfNo2JJsOIUlSb8XWTOz8uQxu+175A9ojimjHYBwXNoMahAJ3G63UkUObP0d7rF4pKD09a+vfKuMUhthVLKo0DABcduNtNPZGedWaI/HF4ZD5tzK3wTeUffUmNI=
Message-ID: <69304d110601021403o59a10c77i3d9ef8dc046e27bd@mail.gmail.com>
Date: Mon, 2 Jan 2006 23:03:08 +0100
From: Antonio Vargas <windenntw@gmail.com>
To: gcoady@gmail.com, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       mingo@elte.hu, tim@physik3.uni-rostock.de, torvalds@osdl.org,
       davej@redhat.com, linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
In-Reply-To: <sq7jr1l1ffgdc5ra26ra6n2ota7osj9c2q@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051229224839.GA12247@elte.hu> <20051230074916.GC25637@elte.hu>
	 <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu>
	 <20051231150831.GL3811@stusta.de> <20060102103721.GA8701@elte.hu>
	 <20060102134228.GC17398@stusta.de>
	 <20060102102824.4c7ff9ad.akpm@osdl.org>
	 <1136227746.2936.46.camel@laptopd505.fenrus.org>
	 <sq7jr1l1ffgdc5ra26ra6n2ota7osj9c2q@4ax.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/2/06, Grant Coady <grant_lkml@dodo.com.au> wrote:
> On Mon, 02 Jan 2006 19:49:06 +0100, Arjan van de Ven <arjan@infradead.org> wrote:
>
> >Maybe the right approach is to start rejecting in reviews new code that
> >uses inline inappropriately. (where "inappropriate" sort of is "more
> >than 3 lines of C unless there is some constant-optimizes-away trick")
>
> Well, I can own up to half a dozen inlines in a .c file, CodingStyle
> suggests to convert macros to static inline, so I did:
>
> /* adm9240 internally scales voltage measurements */
> static const u16 nom_mv[] = { 2500, 2700, 3300, 5000, 12000, 2700 };
>

[snip some static inline functons]

>
> Are these typical targets for non-inline?

according to the latest flamewars, maybe it would be better
to just turn the #defines into static functions instead on static inlines...
guess even better would be to just get CodingStyle fixed ASAP ;)

--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
