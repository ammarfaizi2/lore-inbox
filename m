Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262982AbTIGKRo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 06:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263011AbTIGKRn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 06:17:43 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:51918 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S262982AbTIGKRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 06:17:42 -0400
Date: Sun, 7 Sep 2003 12:17:35 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: jsimmons@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6: spurious recompiles
Message-ID: <20030907101735.GN14436@fs.tum.de>
References: <20030906201417.GI14436@fs.tum.de> <20030907055144.GA1627@mars.ravnborg.org> <20030907070025.GA12822@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907070025.GA12822@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 09:00:25AM +0200, Sam Ravnborg wrote:
> On Sun, Sep 07, 2003 at 07:51:44AM +0200, Sam Ravnborg wrote:
> > On Sat, Sep 06, 2003 at 10:14:18PM +0200, Adrian Bunk wrote:
> > > 2. pnmtologo
> > > The following happens again once, but not when doing a third "make":
> > >   ./scripts/pnmtologo -t mono -n logo_linux_mono -o drivers/video/logo/logo_linux_mono.c drivers/video/logo/logo_linux_mono.pbm
> > 
> > Would you mind to give this patch a spin. Only lightly tested here.
> Tested it a bit more, it was not good. Corrected patch follows.
> I had to spell out the dependencies, otherwise make saw them
> as implicit targets, and deleted the .c files afterwards.

Thanks, this patch seems to fix it.

> Btw the patch contains some general clean-up as well, unrelated to
> the 'spurious recompile' issue.

These are the places where I got rejects in 2.6.0-test4-mm6 (these 
changes are already in the -mm tree).

> 	Sam
>...

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

