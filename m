Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbTBJIMH>; Mon, 10 Feb 2003 03:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264715AbTBJIMH>; Mon, 10 Feb 2003 03:12:07 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:52231 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S264699AbTBJIMF>; Mon, 10 Feb 2003 03:12:05 -0500
Date: Mon, 10 Feb 2003 08:21:40 +0000
From: "'Christoph Hellwig'" <hch@infradead.org>
To: Crispin Cowan <crispin@wirex.com>
Cc: LA Walsh <law@tlinx.org>, "'Christoph Hellwig'" <hch@infradead.org>,
       torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030210082140.A16436@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	Crispin Cowan <crispin@wirex.com>, LA Walsh <law@tlinx.org>,
	torvalds@transmeta.com, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <001001c2d0b0$cf49b190$1403a8c0@sc.tlinx.org> <3E471F21.4010803@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E471F21.4010803@wirex.com>; from crispin@wirex.com on Sun, Feb 09, 2003 at 07:40:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 07:40:17PM -0800, Crispin Cowan wrote:
> >	Also unsupported: The "no-security" model -- where all security 
> >is thrown out (to save memory space and cycles) that was desired for embedded work.
> >
> False: capabilities is now a removable module, which is what Linus asked 
> for.

It's not.  You put a bit of capability logic into a LSM module, but all
the specific calls to capable are still around and turned into an LSM hook -
often near another hook.

> >_\implemented\_ (team members & prjct lead Linda Walsh) to move all
> >security checks out of the kernel into a 'default policy' module.
> >The code to implement this was submitted to the LSM list in June 1991.
> >
> And I actually like that plan. But I still believe it to be too radical 
> for 2.6.

It's too later for 2.6 _now_.  If you started doing this in early 2.5
we'd have a much less messy ACC architecture by now.  

> It has many nice properties, but is much more invasive to the 
> kernel. I think it is a very interesting idea for 2.7, and should be 
> floated past the maintainers who will be impacted to see if it has a 
> hope in hell.

*nod* and until we get that gets implemented we should remove the current
mess..

