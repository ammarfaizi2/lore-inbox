Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262716AbSITOe4>; Fri, 20 Sep 2002 10:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbSITOe4>; Fri, 20 Sep 2002 10:34:56 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:20643
	"EHLO Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S262716AbSITOez>; Fri, 20 Sep 2002 10:34:55 -0400
Date: Fri, 20 Sep 2002 07:39:31 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RESEND] Cleanup (BIN|BCD)_TO_(BCD|BIN) usage/macros
Message-ID: <20020920143931.GH726@opus.bloom.county>
References: <20020917182950.GA726@opus.bloom.county> <3D8776FF.3050504@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D8776FF.3050504@mandrakesoft.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 17, 2002 at 02:39:59PM -0400, Jeff Garzik wrote:

> Tom Rini wrote:
> >Right now there's a bit of a mess with all of the BIN_TO_BCD/BCD_TO_BIN
> >macros in the kernel.  It's defined in a half dozen places, and worse
> >yet, not all places use them the same way.  Most users do something
> >like:
> >if ( ... )
> >   BIN_TO_BCD(x);
> >
> >But in a few places, it's used as:
> >if ( ... )
> >   y = BIN_TO_BCD(x);
> >
> >The following creates include/linux/bcd.h which has the 'normal'
> >BIN_TO_BCD macros, as well as CONVERT_{BIN,BCD}_TO_{BCD,BIN},
> >which are for the second case.
> 
> hmmm... removing all the private definitions certainly makes good sense, 
> but having both CONVERT_foo and foo seems a bit wonky...
> 
> IMO it would be better to have BIN_TO_BCD which returns a value, and 
> __BIN_TO_BCD which has side effects but returns no value...

The other thing, is that in general people seem to expect BIN_TO_BCD(X) to
not return a value, and just convert X.  Would it be better to replace
CONVERT_x to __x then ?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
