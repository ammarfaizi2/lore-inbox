Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268057AbUIBJXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268057AbUIBJXW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 05:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUIBJXV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 05:23:21 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:36620 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S268057AbUIBJW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 05:22:26 -0400
Message-ID: <4136E756.8020105@hist.no>
Date: Thu, 02 Sep 2004 11:26:46 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Hunt <oliverhunt@gmail.com>
CC: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com>
In-Reply-To: <4699bb7b04090202121119a57b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Hunt wrote:

>How would we go about finding out how many data forks were in a file? 
>Because in order to be able to retrieve data from a fork we would need
>to know that the fork were there.  Currently this would imply that we
>go looking through mtab or some such to find out what fs we're running
>on, which seems ugly.
>
>  
>
Depends on how the forks eventually get implemented.
With the file-as-directory concept, all you need is to
look at the file's directory part to see what is there.  (The forks,
implemented as files in a subdirectory.)  It is done the same way
as for an ordinary directory, so nothing "new".

>Alternatively we go through the _exciting_ task of making every other
>fs (with the exceptions of ntfs, and whatever it is that macs use,
>which would need there own custom code) and add code that effectively
>goes
>
>getNumForks(fileref){ return 1;} 
>
>  
>
Necessary if some other mechanism is used, sure.
Helge Hafting
