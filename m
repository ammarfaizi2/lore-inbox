Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278430AbRJSP3J>; Fri, 19 Oct 2001 11:29:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278431AbRJSP3A>; Fri, 19 Oct 2001 11:29:00 -0400
Received: from cs6625129-123.austin.rr.com ([66.25.129.123]:50188 "HELO
	dragon.taral.net") by vger.kernel.org with SMTP id <S278430AbRJSP2o>;
	Fri, 19 Oct 2001 11:28:44 -0400
Date: Fri, 19 Oct 2001 10:30:41 -0500
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
Message-ID: <20011019103041.D30774@taral.net>
In-Reply-To: <3bceefa6.3cf6.0@panix.com> <3BCEF26E.12D69882@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 04:17:02PM +0100, Arjan van de Ven wrote:
> 
> > Exported interfaces are "methods of operation" in the sense of US
> > Copyright Law.  Copyright Law affords no protection to "methods of
> > operation".  The GPL, which gains its strength from Copyright Law, also
> > has no rights in this area.  If a GPLed module does not want other code
> > using its interfaces, they should not be exported.
> 
> I think you're missing one thing: binary only modules are only allowed
> because of an exception license grant Linus made for functions that are
> marked EXPORT_SYMBOL(). EXPORT_SYMBOL_GPL() just says "not part of this 
> exception grant"....

Fine. I (the hypothetical binary driver maker) will just make two
modules -- one which is MODULE_LICENCEd GPL, and the other which is not.
The first will re-export your interfaces as unrestricted ones which the
second can use. Are we going to start insisting on a transitivity of
this restriction? If so, then it's possible that a large number of
interfaces might go...

I also think this is somewhat ridiculous. If I (the binary module maker)
distribute a program which effectively replicates the functionality of
insmod without the licence checking, and distribute that program with my
module, am I violating any restrictions? I don't think so, since it's
the end-user that ends up linking the kernel to the module. No linked
products are actually distributed...

-- 
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Any technology, no matter how primitive, is magic to those who don't
understand it." -- Florence Ambrose
