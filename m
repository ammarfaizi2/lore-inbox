Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262015AbVGEXsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262015AbVGEXsG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVGEXsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:48:06 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:37040 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262015AbVGEXsD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:48:03 -0400
Message-ID: <42CB1C20.3030204@namesys.com>
Date: Tue, 05 Jul 2005 16:47:44 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Masover <ninja@slaphack.com>
CC: Hubert Chan <hubert@uhoreg.ca>, Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<878y0svj1h.fsf@evinrude.uhoreg.ca> <42C4F97B.1080803@slaphack.com> <87ll4lynky.fsf@evinrude.uhoreg.ca> <42CB0328.3070706@namesys.com> <42CB07EB.4000605@slaphack.com> <42CB0ED7.8070501@namesys.com> <42CB1128.6000000@slaphack.com>
In-Reply-To: <42CB1128.6000000@slaphack.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Masover wrote:

>Now, can anyone think of a situation where we want user-created
>hardlinks inside metadata?  More importantly, what do we do about it?
>  
>
I think the equivalent of symlinks would be good enough to get by on for
now for most linking of metafiles.  Maybe some years from now somebody
can fault me for saying this and write a patch to fix it to be better,
at which point I will be happy to concede the point.

So the basic principal here is, one can have hardlinks to directories
without cycles provided that one does not allow any child of the
directory to have a hardlink.  The question is, how cleanly can that
relaxed restriction be coded?

Hans
