Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132855AbRDPGY4>; Mon, 16 Apr 2001 02:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132857AbRDPGYg>; Mon, 16 Apr 2001 02:24:36 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:45834 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132855AbRDPGYd>;
	Mon, 16 Apr 2001 02:24:33 -0400
Date: Mon, 16 Apr 2001 02:25:47 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: "Eric S. Raymond" <esr@snark.thyrsus.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.1.1, wiuth experimental fast mode
Message-ID: <20010416022547.A9524@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	"Albert D. Cahalan" <acahalan@cs.uml.edu>,
	"Eric S. Raymond" <esr@snark.thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104150345.f3F3jxG16241@snark.thyrsus.com> <200104160615.f3G6FHf418941@saturn.cs.uml.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200104160615.f3G6FHf418941@saturn.cs.uml.edu>; from acahalan@cs.uml.edu on Mon, Apr 16, 2001 at 02:15:17AM -0400
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert D. Cahalan <acahalan@cs.uml.edu>:
> > 	* Added fast-mode command to suppress side-effect computation 
> > 	  on slow machines.
> 
> You could put the computation in a low-priority thread, so that it
> still gets done but doesn't mess up responsiveness.

Yes, I've thought about doing exactly this.  It's a huge nasty can of
worms, though, because it would mean that the side effects from
setting a symbol could manifest some unpredictable amount of time
after they were triggered.  And what if the user has taken actions
that set variables during that window?  What if the side-effects
conflict?

Clearly, that way lies madness.  I think my effort would be better spent
speed-tuning the deduction algorithms so fastmode can go away.  
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The men and women who founded our country knew, by experience, that there
are times when the free person's answer to oppressive government has to be
delivered with a bullet.  Thus, the right to bear arms is not just *a*
freedom; it's the mother of all freedoms.  Don't let them disarm you!
