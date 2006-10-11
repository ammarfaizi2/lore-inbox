Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030318AbWJKGJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030318AbWJKGJJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 02:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030645AbWJKGJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 02:09:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:40575 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030318AbWJKGJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 02:09:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=hwXVjxHeU3rG24CcSMlI+1JDdNP6LIc170v7gNdu2hIaqpWm51ktEZazi/BnMeoQeJkWo0Zq7b36NtA5IJIyF5znjrFpdSMlfMgc+Ba7cfAxJ897YdiB/Y7I5++yeiCtpnnBco7Pj0UBjp8PqSgU9cz2vUEsUuj4locTlHZIjAs=
Subject: Re: 2.6.18 suspend regression on Intel Macs
From: =?ISO-8859-1?Q?Fr=E9d=E9ric?= Riss <frederic.riss@gmail.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, len.brown@intel.com
In-Reply-To: <Pine.LNX.4.64.0610101649440.3952@g5.osdl.org>
References: <1160417982.5142.45.camel@funkylaptop>
	 <20061010103910.GD31598@elf.ucw.cz>
	 <1160476889.3000.282.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.64.0610100830370.3952@g5.osdl.org>
	 <1160507296.5134.4.camel@funkylaptop>
	 <1160509121.3000.327.camel@laptopd505.fenrus.org>
	 <1160509584.5134.11.camel@funkylaptop> <20061010195022.GA32134@elf.ucw.cz>
	 <Pine.LNX.4.64.0610101447270.3952@g5.osdl.org>
	 <1160518195.5134.38.camel@funkylaptop>
	 <Pine.LNX.4.64.0610101649440.3952@g5.osdl.org>
Content-Type: text/plain; charset=utf-8
Date: Wed, 11 Oct 2006 08:09:03 +0200
Message-Id: <1160546944.5134.47.camel@funkylaptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 10 octobre 2006 à 16:53 -0700, Linus Torvalds a écrit :
> 
> On Wed, 11 Oct 2006, Frédéric Riss wrote:
> >
> > I was about to send a patch doing exactly the same. It fixes the issue
> > for me. Thanks.
> 
> Hmm. My Mac Mini doesn't restore properly even with it, but I suspect it's 
> the old DRM "resume AGP in the wrong order" problem.

I should have mentioned that I've tested it by patching a 2.6.18 and not
the current git tree (current git wouldn't boot for me, need to
investigate). Maybe something got pulled recently that introduced new
issues?

Fred.

> When trying to verify that, though, I noticed that if I enable the "keep 
> console active over suspend", then it won't even suspend. It hangs after 
> printing "i801_smbus 0000:00:1f.3: suspend".
> 
> I'm wondering what Pavel does for debugging these things, since the claim 
> was that keeping printk() active would make debugging easier. As it is, it 
> just seems to break suspend exactly because it wants to access devices 
> that are turned off.
> 
> Pavel?
> 
> 		Linus

