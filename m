Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVGGGqA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVGGGqA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 02:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbVGGGnx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 02:43:53 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:17346 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261188AbVGGGmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 02:42:53 -0400
Message-ID: <42CCCEEA.7040302@namesys.com>
Date: Wed, 06 Jul 2005 23:42:50 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan Briggs <jbriggs@esoft.com>
CC: Hubert Chan <hubert@uhoreg.ca>,
       "Alexander G. M. Smith" <agmsmith@rogers.com>, ross.biro@gmail.com,
       vonbrand@inf.utfsm.cl, mrmacman_g4@mac.com, Valdis.Kletnieks@vt.edu,
       ltd@cisco.com, gmaxwell@gmail.com, jgarzik@pobox.com, hch@infradead.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
       zam@namesys.com, vs@thebsh.namesys.com, ndiller@namesys.com,
       ninja@slaphack.com, vitaly@thebsh.namesys.com
Subject: Re: reiser4 plugins
References: <42CB1E12.2090005@namesys.com> <1740726161-BeMail@cr593174-a>	 <87hdf8zqca.fsf@evinrude.uhoreg.ca>  <42CB7DE0.4050200@namesys.com> <1120675943.13341.10.camel@localhost>
In-Reply-To: <1120675943.13341.10.camel@localhost>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Briggs wrote:

>On Tue, 2005-07-05 at 23:44 -0700, Hans Reiser wrote:
>  
>
>>Hubert Chan wrote:
>>    
>>
>>>And a question: is it feasible to store, for each inode, its parent(s),
>>>instead of just the hard link count?
>>> 
>>>
>>>      
>>>
>>Ooh, now that is an interesting old idea I haven't considered in 20
>>years.... makes fsck more robust too....
>>    
>>
>
>Hey, sounds like the idea I proposed a couple months ago of storing the
>path names in each file, instead of in directories.  Only better, since
>each path component isn't text but a link instead.
>
>It still has the performance and locking problem of having to update
>every child file when moving a directory tree to a new parent.  On the
>other hand, maybe the benefit is worth the cost.
>  
>
Oh no, don't store the whole path, store just the parent list.  This
will make fsck more robust in the event that the directory gets
clobbered by hardware error.

I don't think it affects the cost of detecting cycles though, I think it
only makes fsck more robust.

Hans
