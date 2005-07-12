Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVGLHqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVGLHqC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 03:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261242AbVGLHqC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 03:46:02 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:42902 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261227AbVGLHp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 03:45:59 -0400
Message-ID: <42D37535.40406@namesys.com>
Date: Tue, 12 Jul 2005 00:45:57 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: David Masover <ninja@slaphack.com>,
       Stefan Smietanowski <stesmi@stesmi.com>, Hubert Chan <hubert@uhoreg.ca>,
       Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<878y0svj1h.fsf@evinrude.uhoreg.ca>	<42C4F97B.1080803@slaphack.com>	<87ll4lynky.fsf@evinrude.uhoreg.ca>	<42CB0328.3070706@namesys.com>	<42CB07EB.4000605@slaphack.com>	<42CB0ED7.8070501@namesys.com>	<42CB1128.6000000@slaphack.com>	<42CB1C20.3030204@namesys.com>	<42CB22A6.40306@namesys.com>	<42CBE426.9080106@slaphack.com>	<42D1F06C.9010905@stesmi.com>	<42D2DB99.9050307@slaphack.com> <17107.28428.30907.184223@cse.unsw.edu.au>
In-Reply-To: <17107.28428.30907.184223@cse.unsw.edu.au>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>
>
>Maybe it is worth repeating Al Viro's suggestion at this point.  I
>don't have a reference but the idea was basically that if you open
>"/foo" and get filedescriptor N, then
>   /proc/self/fds/N-meta
>is a directory which contains all the meta stuff for "/foo".
>Then it is trivial to get the 'meta' stuff given a filedescriptor and
>if you have a pathname, you can always get yourself a filedescriptor.
>  
>
This sound like it might be cute, but filedescriptors are too heavy
weight for stat data accesses in quantity.

In general, the whole file handle paradigm is too heavy for lightweight
files.

Hans
