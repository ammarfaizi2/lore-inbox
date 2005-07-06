Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262436AbVGGARs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262436AbVGGARs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 20:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbVGFUF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:05:27 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:15233 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S262453AbVGFSNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 14:13:47 -0400
Message-ID: <42CC1F53.7070301@namesys.com>
Date: Wed, 06 Jul 2005 11:13:39 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nate Diller <nate@namesys.com>
CC: Neil Brown <neilb@cse.unsw.edu.au>, David Masover <ninja@slaphack.com>,
       Hubert Chan <hubert@uhoreg.ca>, Ross Biro <ross.biro@gmail.com>,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Kyle Moffett <mrmacman_g4@mac.com>, Valdis.Kletnieks@vt.edu,
       Lincoln Dale <ltd@cisco.com>, Gregory Maxwell <gmaxwell@gmail.com>,
       Jeff Garzik <jgarzik@pobox.com>, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>,
       Alexander Zarochentcev <zam@namesys.com>, vs <vs@thebsh.namesys.com>,
       Nate Diller <ndiller@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<878y0svj1h.fsf@evinrude.uhoreg.ca>	<42C4F97B.1080803@slaphack.com>	<87ll4lynky.fsf@evinrude.uhoreg.ca>	<42CB0328.3070706@namesys.com>	<42CB07EB.4000605@slaphack.com>	<42CB0ED7.8070501@namesys.com>	<42CB1128.6000000@slaphack.com>	<42CB1E12.2090005@namesys.com> <17099.15101.233487.623549@cse.unsw.edu.au> <42CC019B.70503@namesys.com>
In-Reply-To: <42CC019B.70503@namesys.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nate Diller wrote:

>
>
> as an example, if a program were to store some things it needs access
> to in its executable's attributes, it should have the option of
> keeping a hard reference to something, so that it can't be deleted out
> from underneath.  this enables sane sharing of resources without
> ownership tracking problems (see windows DLL hell for details).  the
> attribute space should be indistinguishable from the rest of the
> namespace, and should be able to link (soft or hard) anywhere in the
> FS.  anything less is too much work for too little reward.
>
You already have a problem with hardlinks not crossing mount points, but
I understand your point.  If we can write code for solving the cycle
problem cleanly, it would be best.
