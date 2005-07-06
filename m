Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVGFI0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVGFI0y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 04:26:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262227AbVGFI0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 04:26:53 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:38911 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262172AbVGFGpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 02:45:11 -0400
Message-ID: <42CB7DE0.4050200@namesys.com>
Date: Tue, 05 Jul 2005 23:44:48 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hubert Chan <hubert@uhoreg.ca>
CC: "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       ninja@slaphack.com, vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a> <87hdf8zqca.fsf@evinrude.uhoreg.ca>
In-Reply-To: <87hdf8zqca.fsf@evinrude.uhoreg.ca>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hubert Chan wrote:

>On Tue, 05 Jul 2005 20:50:08 -0400 EDT, "Alexander G. M. Smith" <agmsmith@rogers.com> said:
>
>  
>
>>That sounds equivalent to no hard links (other than the usual parent
>>directory one).  If there's any directory with two links to it, then
>>there will be a cycle somewhere!
>>    
>>
>
>What we want is no directed cycles.  That is A is the parent of B is the
>parent of C is the parent of A.  We don't care about A is the parent of
>B is the parent of C; A is the parent of B is the parent of C.
>
>OK, here's a random idea that just popped into my head, and to which
>I've given little thought (read: none whatsoever), and may be the
>stupidest idea ever proposed on LKML, but thought I would just toss it
>out to see if it could stimulate someone to come up with something
>better (read: sane):  Conceptually, foo/.... is just a symlink to
>/meta/[filesystem]/[inode of foo].
>  
>
Except that we want the metafiles to go away when the base file goes away.

>And a question: is it feasible to store, for each inode, its parent(s),
>instead of just the hard link count?
>  
>
Ooh, now that is an interesting old idea I haven't considered in 20
years.... makes fsck more robust too....

