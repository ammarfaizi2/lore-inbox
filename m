Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132540AbRDNUsQ>; Sat, 14 Apr 2001 16:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132547AbRDNUsG>; Sat, 14 Apr 2001 16:48:06 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:45062 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132540AbRDNUr7>;
	Sat, 14 Apr 2001 16:47:59 -0400
Date: Sat, 14 Apr 2001 16:49:14 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Marko Kreen <marko@l-t.ee>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org
Subject: Re: comments on CML 1.1.0
Message-ID: <20010414164914.A12838@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Marko Kreen <marko@l-t.ee>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200104140317.f3E3Hv805992@snark.thyrsus.com> <20010414150421.A28066@l-t.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010414150421.A28066@l-t.ee>; from marko@l-t.ee on Sat, Apr 14, 2001 at 03:04:21PM +0200
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marko Kreen <marko@l-t.ee>:
> Using CML2 1.1.0 'menuconfig' on clean 2.4.3 (mach is PPro 180)
> 
> Suggestions:
> 
> * the 'N' should be shown as ' ' as in menuconfig - it is
>   visually much better to get overview of whole screenful.
>   'Y'/'M' and 'N' are basically of 'same size' so you must look
>   directly on letter to understand what it is - not good.

I've gone this one better.  It's now "Y", "m", " ", so the m and y
responses are easily distinguished.
 
> * the menuconfig had nice shortcut: when you pressed 'm' on
>   [YN] field, it put 'y' there without questions.  So you could
>   use only 2 keys to configure one screen: 'n/m'.  this meant
>   you did not need to move fingers around and think about it
>   so much - big thing when you are not touch-typer...

Implemented.

> * the colors are hard to see (red/blue on black).  Probably
>   matter of terminal settings.  I do not have any productive
>   ideas tho...  Probably to get best experience to as much
>   people as possible the less colors are used the better.
>   
>   The 'blue: last visited submenu' is unnecessary.  Especially
>   because it later turns green...  And the 'red' vs. 'green'
>   thing.  I guess the green should be used for 'visited entries'
>   too.  Now the red means like 'Doh.  So I should not have
>   touched this?'.  Confusing.
> 
>   In other words: if there are too much colors, they become
>   a thing that should be separately learned, not a helpful
>   aid.
> 
>   All this IMHO ofcourse.  Colors are 'matter of taste' thing
>   so there probably is not exact Rigth Thing.

You make good points.  In the 1.1.1, blue and yellow/brown will be gone;
it's just green for everything visited.

> Bugs/complaints:
> 
> * aic7xxx is not updated (defaults: are 8/5 should be 253/5000)
>   (this from arch/i386/defconfig maybe?)

Fixed.

> * 'IDE chipset support' nesting is very confusing - compare
>   to menuconfig.  I would say even 'wrong'...
>   (eg. 'PIIXn tuning' is is under 'PIIXn support' which is not
>   under 'ATA works in progress'.

Rules-file patches will be cheerfully accepted.
 
> * screen is redrawn after _every_ keystroke - not only in moving
>   around, but even when you are on input field...

I know.  The workaround is to use gnome-term, which for some reason
doesn't show this.  It's tops on my longer-term to-do list.

> * input field: when there is some default and I start typing it
>   should either clear it or append.

On my to-do list.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The men and women who founded our country knew, by experience, that there
are times when the free person's answer to oppressive government has to be
delivered with a bullet.  Thus, the right to bear arms is not just *a*
freedom; it's the mother of all freedoms.  Don't let them disarm you!
