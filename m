Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132829AbRDUTJn>; Sat, 21 Apr 2001 15:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132828AbRDUTJe>; Sat, 21 Apr 2001 15:09:34 -0400
Received: from duba06h06-0.dplanet.ch ([212.35.36.67]:49163 "EHLO
	duba06h06-0.dplanet.ch") by vger.kernel.org with ESMTP
	id <S132829AbRDUTJV>; Sat, 21 Apr 2001 15:09:21 -0400
Message-ID: <3AE1E77C.AF1402F4@dplanet.ch>
Date: Sat, 21 Apr 2001 22:03:08 +0200
From: "Giacomo A. Catenazzi" <cate@dplanet.ch>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Request for comment -- a better attribution system
In-Reply-To: <20010421114942.A26415@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> This is a proposal for an attribution metadata system in the Linux kernel
> sources.  The goal of the system is to make it easy for people reading
> any given piece of code to identify the responsible maintainer.  The motivation
> for this proposal is that the present system, a single top-level MAINTAINERS
> file, doesn't seem to be scaling well.
> 
> In this system, most files will contain a "map block".  A map block is a
> metadata section embedded in a comment near the beginning of the file.
> Here is an example map block for my kxref.py tool:
> 

Good!

> And here's what a map block should look like in general:
> 
> %Map:
> T: Description of this unit for map purposes
> P: Person
> M: Mail patches to
> L: Mailing list that is relevant to this area
> W: Web-page with status/info
> C: Controlling configuration symbol
> D: Date this meta-info was last updated
> S: Status, one of the following:
 
> There may be more than one P: field per map block.  There should be exactly one
> M: field.
> 
> The D: field may have the special value `None' meaining that this map block
> was translated from old information which has not yet been confirmed with the
> responsible maintainer.
> 
> Note that this is the same set of conventions presently used in the
> MAINTAINERS file, with only the T:, D:, and C: fields being new.  The
> contents of the C: field, if present, should be the name of the
> CONFIG_ symbol that controls the inclusion of this unit in a kernel.
> 
> (Map blocks are terminated by a blank line.)
> 

We should use the same filed name of CREDITS e.g. D: for Description.
(maybe you can invert D: description and T: time of last update)

It whould nice also if we include the type of the license (GPL,...).
This for a fast parsing (and maybe also to replace the few lines
of license)

Instead of C: it is more important (IMHO) to include the module name.
Maybe we can include both (modules name are always lower case).
I think that the inclusion of the config option is not important (
considering that it can be easily parsed from the kaos' new makefiles).


	giacomo
