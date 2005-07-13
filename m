Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262518AbVGMBYB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262518AbVGMBYB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 21:24:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262825AbVGMBWP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 21:22:15 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:8091 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262896AbVGMBUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 21:20:43 -0400
Message-ID: <42D46C59.5010707@namesys.com>
Date: Tue, 12 Jul 2005 18:20:25 -0700
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
       Nate Diller <ndiller@namesys.com>,
       Vladimir Demidov <demidov@namesys.com>
Subject: Re: reiser4 plugins
References: <hubert@uhoreg.ca>	<200506290509.j5T595I6010576@laptop11.inf.utfsm.cl>	<87hdfgvqvl.fsf@evinrude.uhoreg.ca>	<8783be6605062914341bcff7cb@mail.gmail.com>	<878y0svj1h.fsf@evinrude.uhoreg.ca>	<42C4F97B.1080803@slaphack.com>	<87ll4lynky.fsf@evinrude.uhoreg.ca>	<42CB0328.3070706@namesys.com>	<42CB07EB.4000605@slaphack.com>	<42CB0ED7.8070501@namesys.com>	<42CB1128.6000000@slaphack.com>	<42CB1C20.3030204@namesys.com>	<42CB22A6.40306@namesys.com>	<42CBE426.9080106@slaphack.com>	<42D1F06C.9010905@stesmi.com>	<42D2DB99.9050307@slaphack.com>	<17107.28428.30907.184223@cse.unsw.edu.au>	<42D37535.40406@namesys.com> <17108.23229.448917.291560@cse.unsw.edu.au>
In-Reply-To: <17108.23229.448917.291560@cse.unsw.edu.au>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

>On Tuesday July 12, reiser@namesys.com wrote:
>  
>
>>Neil Brown wrote:
>>
>>    
>>
>>>Maybe it is worth repeating Al Viro's suggestion at this point.  I
>>>don't have a reference but the idea was basically that if you open
>>>"/foo" and get filedescriptor N, then
>>>  /proc/self/fds/N-meta
>>>is a directory which contains all the meta stuff for "/foo".
>>>Then it is trivial to get the 'meta' stuff given a filedescriptor and
>>>if you have a pathname, you can always get yourself a filedescriptor.
>>> 
>>>
>>>      
>>>
>>This sound like it might be cute, but filedescriptors are too heavy
>>weight for stat data accesses in quantity.
>>
>>In general, the whole file handle paradigm is too heavy for lightweight
>>files.
>>    
>>
>
>That may well be true, but is completely orthogonal to filesystem name
>semantics. 
>
>If you find file descriptors too slow, come up with an alternate (I
>suspect you have in the reiser4 syscall, but I haven't looked at
>that yet), implement it in the VFS, and show the world benchmarks of
>real-world applications that go faster with this new interface.
>
>I doubt that you would then have a great deal of trouble in getting
>the interface accepted (some trouble of course as you will need to
>convince a few people, but numbers speak quite loudly).
>
>I suspect that there might need to be a new internal interface into
>filesystems, and filesystems which don't provide that will not get the
>same speed benefit, but that is perfectly acceptable.
>
>NeilBrown
>
>
>  
>
We need time, and then we can demonstrate sys_reiser4, it is not ready
for showing yet.....

Hans
