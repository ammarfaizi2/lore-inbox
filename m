Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135533AbRDSOIU>; Thu, 19 Apr 2001 10:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135705AbRDSOIM>; Thu, 19 Apr 2001 10:08:12 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:14346 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135533AbRDSOID>;
	Thu, 19 Apr 2001 10:08:03 -0400
Date: Thu, 19 Apr 2001 09:36:13 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Richard Gooch <rgooch@atnf.csiro.au>, "Edward S. Marshall" <esm@logic.net>,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: Cross-referencing frenzy
Message-ID: <20010419093613.A32121@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Richard Gooch <rgooch@atnf.csiro.au>,
	"Edward S. Marshall" <esm@logic.net>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20010419013748.C29686@thyrsus.com> <200104190926.LAA06753@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104190926.LAA06753@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Thu, Apr 19, 2001 at 11:26:08AM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff <R.E.Wolff@BitWizard.nl>:
> I think it should be possible to do: 
> 
> /* to enable the special stuff, change the "undef" to "define",
>    If you really want you can add this to Config.in so that you're presented
>    with this choice when configuring your kernel. But it's not neccesary
>    for the general public to always see this toggle.  */
> #undef CONFIG_SX_SPECIALSTUFF
> 
> #ifdef CONFIG_SX_SPECIALSTUFF
> ...
> 
> #endif

Yes, I could write and test code to handle this in about twenty minutes.
And I was about to do it when I realized that it would be the wrong thing.

The right answer is that CONFIG_SX_SPECIALSTUFF *should* be flagged as
an error -- because it doesn't belong in the CONFIG_ namespace, which
by definition should be reserved for things the configurators control.

It should be called something else: perhaps ENABLE_SX_SPECIALSTUFF
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The IRS has become morally corrupted by the enormous power which we in
Congress have unwisely entrusted to it. Too often it acts like a
Gestapo preying upon defenseless citizens.
	-- Senator Edward V. Long
