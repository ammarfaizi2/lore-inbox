Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285077AbRLLGjZ>; Wed, 12 Dec 2001 01:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285079AbRLLGjQ>; Wed, 12 Dec 2001 01:39:16 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:21435
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S285077AbRLLGjD>; Wed, 12 Dec 2001 01:39:03 -0500
Date: Wed, 12 Dec 2001 01:28:46 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 1.9.6 is available
Message-ID: <20011212012846.A6751@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net
In-Reply-To: <20011212000506.A5099@thyrsus.com> <15846.1008138725@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15846.1008138725@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Wed, Dec 12, 2001 at 05:32:05PM +1100
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au>:
> This works for me.
> 
> --- cml2-1.9.6/cmlconfigure.py	Sun Dec  9 19:27:31 2001
> +++ 2.4.16-kbuild-2.5/scripts/cmlconfigure.py	Wed Dec 12 17:23:01 2001
> @@ -1009,7 +1009,7 @@
>  
>      def query_popup(self, prompt, initval=None):
>          "Pop up a window to accept a string."
> -        maxsymwidth = 30	# Constant
> +        maxsymwidth = self.columns - len(prompt) - 2
>          if initval and len(initval) > maxsymwidth:
>              self.help_popup("PRESSANY", (lang["TOOLONG"],), beep=1) 
>              return initval
> 
> Warning, that is my first bit of Python code (Oh no, now I'm
> contaminated too :-).

And a very nice bit it is too :-).

I actually ended up making a similar change shortly after I wrote you.

Right now I'm testing Jan Harknes's CML1 backport patch.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

I do not find in orthodox Christianity one redeeming feature.
	-- Thomas Jefferson
