Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269362AbUICIcK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269362AbUICIcK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 04:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269374AbUICIbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 04:31:55 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:18695 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S269378AbUICIYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 04:24:18 -0400
Message-ID: <41382B37.1000901@hist.no>
Date: Fri, 03 Sep 2004 10:28:39 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Spam <spam@tnonline.net>, Oliver Hunt <oliverhunt@gmail.com>,
       Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com> <4699bb7b04090202121119a57b@mail.gmail.com> <4136E756.8020105@hist.no> <4699bb7b0409020245250922f9@mail.gmail.com>            <812032218.20040902120259@tnonline.net> <200409022239.i82MdmnO015327@turing-police.cc.vt.edu>
In-Reply-To: <200409022239.i82MdmnO015327@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Thu, 02 Sep 2004 12:02:59 +0200, Spam said:
>
>  
>
>>  The meta-data should be deleted if it the file is copied or moved to
>>  a medium that doesn't support it. However a _warning_ may be shown
>>  to the user if there is risk to loose data.
>>    
>>
>
>OK... I'll bite.  How do you report the warning to the user if you're using
>an unenhanced utility to copy a file to a file system that may be lossy?
>  
>
Well, _if_ you're using my sort of file-as-dir then you'd expect a
plain "cp" to only copy the file.  You'd use cp -a to copy the
file's subdirectory too.  If you're copying to anther filesystem
that doesn't support file-as-directory then "cp -a" won't be able
to create a directory with the same name as the file, and
will do whatever cp does in such a situation.  I.e. something like
"NAME exists but is not a directory".

Helge Hafting

