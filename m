Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261968AbVGEX4I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261968AbVGEX4I (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 19:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbVGEX4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 19:56:08 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:726 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261968AbVGEX4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 19:56:04 -0400
Message-ID: <42CB1E12.2090005@namesys.com>
Date: Tue, 05 Jul 2005 16:56:02 -0700
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
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got it slightly wrong.

One can have hardlinks to a directory without cycles provided that one
does not have hardlinks from the children of that directory to any file
not a child of that directory.  (Mountpoints currently implement that
restriction.)

Question: can one implement that lesser restriction above with elegant
code?  Is the greater restriction below easier to code?  (If no to the
first and yes to the second is correct, then I can accept the greater
restriction described below.)

One can have hardlinks to directories
without cycles provided that one does not allow any child of the
directory to have a hardlink.

Hans

