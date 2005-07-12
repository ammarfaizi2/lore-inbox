Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVGLXlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVGLXlb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 19:41:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262431AbVGLXla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 19:41:30 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:26267 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262479AbVGLXlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 19:41:16 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: David Masover <ninja@slaphack.com>
Date: Wed, 13 Jul 2005 09:40:26 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17108.21738.774180.21984@cse.unsw.edu.au>
Cc: Stefan Smietanowski <stesmi@stesmi.com>, Hans Reiser <reiser@namesys.com>,
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
In-Reply-To: message from David Masover on Tuesday July 12
References: <hubert@uhoreg.ca>
	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>
	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>
	<8783be6605062914341bcff7cb@mail.gmail.com>
	<878y0svj1h.fsf@evinrude.uhoreg.ca>
	<42C4F97B.1080803@slaphack.com>
	<87ll4lynky.fsf@evinrude.uhoreg.ca>
	<42CB0328.3070706@namesys.com>
	<42CB07EB.4000605@slaphack.com>
	<42CB0ED7.8070501@namesys.com>
	<42CB1128.6000000@slaphack.com>
	<42CB1C20.3030204@namesys.com>
	<42CB22A6.40306@namesys.com>
	<42CBE426.9080106@slaphack.com>
	<42D1F06C.9010905@stesmi.com>
	<42D2DB99.9050307@slaphack.com>
	<17107.28428.30907.184223@cse.unsw.edu.au>
	<42D44EA9.7030700@slaphack.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
X-CSE-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on 
	note.orchestra.cse.unsw.EDU.AU
X-CSE-Spam-Level: 
X-CSE-Spam-Status: No, score=-4.5 required=5.0 tests=ALL_TRUSTED,BAYES_00 
	autolearn=ham version=3.0.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 12, ninja@slaphack.com wrote:
> > 
> > Maybe it is worth repeating Al Viro's suggestion at this point.  I
> > don't have a reference but the idea was basically that if you open
> > "/foo" and get filedescriptor N, then
> >    /proc/self/fds/N-meta
> 
> How am I supposed to get there with a shell script?


function get_meta() 
{
   var=$1
   file=$2
   meta=$3
   val=`cat /proc/self/fd/3-meta/$meta < $file`
   eval var=\$val
}

then
   get_meta varname /home/foo/bar username

will read the 'username' meta-file of 'home/foo/bar' and place it in
varname.

Is that what you wanted?

NeilBrown
