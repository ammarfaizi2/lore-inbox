Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVLHQnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVLHQnI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 11:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVLHQnI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 11:43:08 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:31758 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932208AbVLHQnH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 11:43:07 -0500
To: Arjan van de Ven <arjan@infradead.org>
Cc: Emmanuel Fleury <emmanuel.fleury@labri.fr>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to enable/disable security features on mmap() ?
References: <43983EBE.2080604@labri.fr>
	<1134051272.2867.63.camel@laptopd505.fenrus.org>
	<43984154.5050502@labri.fr> <43984595.1090406@labri.fr>
	<1134053349.2867.65.camel@laptopd505.fenrus.org>
	<4398493E.50508@labri.fr>
	<Pine.LNX.4.61.0512081011020.32448@chaos.analogic.com>
	<4398516F.1020101@labri.fr>
	<1134056348.2867.76.camel@laptopd505.fenrus.org>
From: Nix <nix@esperi.org.uk>
X-Emacs: if SIGINT doesn't work, try a tranquilizer.
Date: Thu, 08 Dec 2005 16:42:55 +0000
In-Reply-To: <1134056348.2867.76.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "8 Dec 2005 15:39:50 -0000")
Message-ID: <8764pzv8ts.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8 Dec 2005, Arjan van de Ven yowled:
>> Moreover, the libc location (and all other dynamic libs) is not
>> randomized under x86_64. I have no explanation for this. :-/
> 
> see above; in addition prelink may be interfering with this.

Indeed; prelinked stuff is not randomized. If you want both, prelink
with -R gives the same benefits as ASLR of the shared library location,
pretty much (obviously the libraries have the same address in every
process --- that's kind of the point --- but what that address is is
randomly selected at prelink time).

Prelinking should not affect stack layout randomization.

-- 
`Don't confuse the shark with the remoras.' --- Rob Landley

