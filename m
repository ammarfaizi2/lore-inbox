Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135898AbRDZTbz>; Thu, 26 Apr 2001 15:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135899AbRDZTbq>; Thu, 26 Apr 2001 15:31:46 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:23052 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135898AbRDZTbe>;
	Thu, 26 Apr 2001 15:31:34 -0400
Date: Thu, 26 Apr 2001 15:33:13 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.2.8 is available
Message-ID: <20010426153313.A19044@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 1.2.8: Thu Apr 26 15:18:38 EDT 2001
	* Major internal speedup; symbol evaluation is much faster now.

Symbol evaluation was the speed bottleneck in the configurator for quite a
while.  Thanks to a reorganization of one of the central data structures,
it's now down in the profiler noise.  As a result, many operations like 
commits and file loading are now so fast that I've removed their twirly-baton
progress indicators.

The new slowdown king is the algebraic-simplification code for constraints.
Greg Banks and I have been kicking around some ideas about common-subexpression
elimination that might lead to big speedups here as well, but it's a complex
change that might take a while. 

It's beginning to look like I might be able to remove the fastmode crock
after the next round of tuning.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Militias, when properly formed, are in fact the people themselves and
include all men capable of bearing arms. [...] To preserve liberty it is
essential that the whole body of the people always possess arms and be
taught alike, especially when young, how to use them.
        -- Senator Richard Henry Lee, 1788, on "militia" in the 2nd Amendment
