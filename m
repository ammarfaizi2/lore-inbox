Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132608AbRDQNPb>; Tue, 17 Apr 2001 09:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbRDQNPL>; Tue, 17 Apr 2001 09:15:11 -0400
Received: from [24.70.141.118] ([24.70.141.118]:30449 "EHLO asdf.capslock.lan")
	by vger.kernel.org with ESMTP id <S132606AbRDQNPD>;
	Tue, 17 Apr 2001 09:15:03 -0400
Date: Tue, 17 Apr 2001 09:14:48 -0400 (EDT)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
X-X-Sender: <mharris@asdf.capslock.lan>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: james rich <james.rich@m.cc.utah.edu>, <linux-kernel@vger.kernel.org>,
        <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] CML2 1.1.3 is available
In-Reply-To: <20010416205556.A22960@thyrsus.com>
Message-ID: <Pine.LNX.4.33.0104170909470.17111-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
X-Spam-To: uce@ftc.gov
Copyright: Copyright 2001 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Apr 2001, Eric S. Raymond wrote:

>Date: Mon, 16 Apr 2001 20:55:56 -0400
>From: Eric S. Raymond <esr@thyrsus.com>
>To: james rich <james.rich@m.cc.utah.edu>
>Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
>Content-Type: text/plain; charset=us-ascii
>Subject: Re: [kbuild-devel] CML2 1.1.3 is available
>
>james rich <james.rich@m.cc.utah.edu>:
>> > Instead, read the colors from the .Xdefaults system.
>>
>> Yes, truly this should be done.  Sensible defaults should be used (and I
>> think we may be at that point) and then use .Xdefaults (.Xresources or
>> whatever) to allow site overrides.  And I really do think .Xdefaults and
>> not .xconfigrc or something.  I've already got enough .files and I like
>> the syntax of .Xdefaults.
>
>That way lies featuritis, IMO.

Agreed.

>If there were already a library in ths stock Python distribution to digest
>.Xdefaults files I might consider this.  Perhaps I'll write one.  But I'm
>not going to bulk up the CML2 code with this marginal feature.

This presumes one is using X.  On a non-X system, .Xdefaults
should mean nothing.  If anything I think cml2 is no different
from anything else.  Some sane colors should be chosen to default
to, preferably not too far off from CML1menuconfig, and leave it
more or less like that.  If it _must_ be configureable, put it in
a ~/.cmlrc

Then do the equiv of:

${CMLRC:=~/.cmlrc}

If someone doesn't like the extra dotfile in ~, they can set

	CMLRC=~/.etc/.cmlrc

or somesuch from ~/.bashrc and friends.  Anything more would be
indeed featureitis IMHO, or abusing a defined file format
(Xdefaults).




----------------------------------------------------------------------
    Mike A. Harris  -  Linux advocate  -  Free Software advocate
          This message is copyright 2001, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

