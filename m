Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288242AbSACHoZ>; Thu, 3 Jan 2002 02:44:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288241AbSACHoQ>; Thu, 3 Jan 2002 02:44:16 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:12934
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288244AbSACHoF>; Thu, 3 Jan 2002 02:44:05 -0500
Date: Thu, 3 Jan 2002 02:31:05 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Andrew Rodland <arodland@noln.com>
Cc: linux-kernel@vger.kernel.org, relson@osagesoftware.com
Subject: Re: CML2 funkiness
Message-ID: <20020103023105.A5434@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Andrew Rodland <arodland@noln.com>, linux-kernel@vger.kernel.org,
	relson@osagesoftware.com
In-Reply-To: <20020102100311.A7819@thyrsus.com> <web-54809847@admin.nni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <web-54809847@admin.nni.com>; from arodland@noln.com on Thu, Jan 03, 2002 at 01:40:15AM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Rodland <arodland@noln.com>:
> I found it!
> The culprit: a bit of confusion over 'private'.
> All of the not-saved symbols were just guards for 'do we
>  want to display question X'... so they were marked
>  private, so as not to clutter up the kernel (I assume).
>  However, this prevents them from getting written to
>  .config/config.out as well! Easy fix is to un-private
>  them, long-term is (as I see it) either to create a new
>  equivalent to private that somehow lets the symbol get
>  written to defconfig, but prevents it from becoming a
>  kernel define, or just to blow it off and don't worry
>  about it, and leave them normal symbols. However, it's
>  1:30AM and I might be missing something.

I think the right thing will be to write private symbols into config.out,
but with an attached PRIVATE label that stops configtrans.py from 
translating these into defines for the autoconf.h file.

That's what I've done for the upcoming CML 2.0.0 release.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Question with boldness even the existence of a God; because, if there
be one, he must more approve the homage of reason, than that of
blindfolded fear.... Do not be frightened from this inquiry from any
fear of its consequences. If it ends in the belief that there is no
God, you will find incitements to virtue in the comfort and
pleasantness you feel in its exercise...
	-- Thomas Jefferson, in a 1787 letter to his nephew
