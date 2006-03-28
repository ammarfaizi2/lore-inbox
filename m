Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWC1Tz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWC1Tz2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 14:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbWC1Tz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 14:55:28 -0500
Received: from sa9.bezeqint.net ([192.115.104.23]:50635 "EHLO sa9.bezeqint.net")
	by vger.kernel.org with ESMTP id S1751263AbWC1Tz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 14:55:28 -0500
From: Shlomi Fish <shlomif@iglu.org.il>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: [PATCH] PoC "make xconfig" Search Facility
Date: Tue, 28 Mar 2006 21:53:04 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <200603272150.42305.shlomif@iglu.org.il> <20060328104337.bb646fad.rdunlap@xenotime.net>
In-Reply-To: <20060328104337.bb646fad.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603282153.05241.shlomif@iglu.org.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 March 2006 20:43, Randy.Dunlap wrote:
> On Mon, 27 Mar 2006 21:50:41 +0200 Shlomi Fish wrote:
> > Hi all!
> >
> > [ I'm not subscribed to this list so please CC me on your replies. ]
> >
> > This patch adds a proof-of-concept search facility to "make xconfig".
> > Current problems and limitations:
> >
> > 1. Only case-insensitive single-substring search is supported.
> >
> > 2. The style is completely wrong, as I could not find a suitable vim
> > configuration for editing Linux kernel source (and Google was not help).
> > If anyone can refer me to one, I'll be grateful.
>
> I don't know of a vim config for kernel source code.

Too bad. :(

> Just read/use Documentation/CodingStyle, although for this code that
> probably doesn't matter so much (since this isn't kernel run-time code).

Thing is when I enter tabs by default in Vim it uses 4 whitespace, and I need 
it to insert a real tab. This is just an example, I want to edit this in 
comfort.

Surely some kernel hackers use Vim, and someone must have come up with a vim 
config for editing kernel source.

>
> > 3. At the moment the results are displayed in a listbox as text. One
> > cannot go from the result node to the place to toggle it in the
> > configuration. (much less from one of it ancessorts)
> >
> > But it works!
> >
> > The patch is against kernel 2.6.16-git13.
> >
> > Comments, suggestions, corrections, and flames are welcome.
>
> Thanks.  It's useful and a good start.

Thanks.

>
> A one-line comment about how to invoke it would have been nice:
> Use Edit/Find or Ctrl-F to invoke the search (find) tool.
>

Where do you want this comment in? In the source code? In the application 
itself? Somewhere else?

> To be really useful it needs to display items that SELECT the search string
> IMO.  Look at how menuconfig can do that.
>
> E.g., for FW_LOADER (my favorite because it keeps me from disabling HOTPLUG
> so often), using /FW_LOADER in menuconfig tells me what SELECTs FW_LOADER
> as well as where it's defined.

Yes, I realise that. Of course implementing it in "make xconfig" would be 
completely different than in "make menu config".

>
> Being able to enter more queries without leaving the dialog box is
> nice/good.
>
> Oh, and patches should apply with 'patch -p1' (i.e., their filenames should
> begin with linux-tree/scripts/ etc., not with scripts/*).

OK, I'll keep it in mind.

Regards,

	Shlomi Fish

---------------------------------------------------------------------
Shlomi Fish      shlomif@iglu.org.il
Homepage:        http://www.shlomifish.org/

95% of the programmers consider 95% of the code they did not write, in the
bottom 5%.
