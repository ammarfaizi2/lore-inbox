Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262286AbVDFTJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262286AbVDFTJF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 15:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVDFTJD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 15:09:03 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:61618 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262286AbVDFTIn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 15:08:43 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: Renate Meijer <kleuske@xs4all.nl>
Subject: Re: [08/08] uml: va_copy fix
Date: Wed, 6 Apr 2005 21:13:59 +0200
User-Agent: KMail/1.7.2
Cc: =?iso-8859-1?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       jdike@karaya.com, linux-kernel@vger.kernel.org, stable@kernel.org,
       Greg KH <gregkh@suse.de>
References: <20050405164539.GA17299@kroah.com> <20050406113233.GD7031@wohnheim.fh-wedel.de> <14410feafdb3a83e1ae457b93e593b81@xs4all.nl>
In-Reply-To: <14410feafdb3a83e1ae457b93e593b81@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200504062113.59283.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 14:04, Renate Meijer wrote:
> On Apr 6, 2005, at 1:32 PM, Jörn Engel wrote:
> > On Tue, 5 April 2005 22:18:26 +0200, Renate Meijer wrote:

> >
> > You did read include/linux/compiler.h, didn't you?

> So instead of applying this patch, simply
>
> #ifdef VERSION_MINOR < WHATEVER
> #define va_copy __va_copy
> #endif
>
> in include/linux/compiler_gcc2.h
>
> Thus solving the problem without having to invade compiler namespace all
> over the place, but doing so in *one* place only.
About this one: thanks for suggesting this and being constructive, I'll do 
ASAP (if I don't forget) this for the -bk tree. However, I think that Greg KH 
for the stable tree would prefer a local tested patch rather than a global 
one with possible side effects, right Greg?

Also, I hope this discussion does not count as a vote for the -stable tree 
inclusion (since dropping GCC 2 support in the -stable tree is exactly the 
purpose of this tree, right ;-) ? ).
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

