Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWEMLSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWEMLSW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 07:18:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932351AbWEMLSW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 07:18:22 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:46092 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S932339AbWEMLSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 07:18:22 -0400
Date: Sat, 13 May 2006 13:18:02 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Mark Rosenstand <mark@borkware.net>, linux-kernel@vger.kernel.org
Subject: Re: Executable shell scripts
Message-ID: <20060513111802.GI11191@w.ods.org>
References: <20060513103841.B6683146AF@hunin.borkware.net> <1147517786.3217.0.camel@laptopd505.fenrus.org> <20060513110324.10A38146AF@hunin.borkware.net> <1147518432.3217.2.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1147518432.3217.2.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2006 at 01:07:12PM +0200, Arjan van de Ven wrote:
> On Sat, 2006-05-13 at 13:03 +0200, Mark Rosenstand wrote:
> > Arjan van de Ven <arjan@infradead.org> wrote:
> > > On Sat, 2006-05-13 at 12:38 +0200, Mark Rosenstand wrote:
> > > > Hi,
> > > > 
> > > > Is it in any (reasonable) way possible to make Linux support executable
> > > > shell scripts? Perhaps through binfmt_misc?
> > > 
> > > ehhhhhh this is already supposed to work.
> > 
> > It doesn't:
> > 
> > bash-3.00$ cat << EOF > test
> > > #!/bin/sh
> > > echo "yay, I'm executing!"
> > > EOF
> > bash-3.00$ chmod 111 test
> > bash-3.00$ ./test
> > /bin/sh: ./test: Permission denied
    ^^^^^^^

> is your script readable as well? 111 is just weird/odd.

BTW, Mark, you should have noticed that you script was executed and that
it's /bin/sh which cannot read it. At the risk of repeating myself, please
do a 'man chmod'.

Willy

