Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269031AbUIHJLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269031AbUIHJLQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 05:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269030AbUIHJLQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 05:11:16 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:20239 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S269029AbUIHJJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 05:09:12 -0400
Message-ID: <413ECD46.40707@hist.no>
Date: Wed, 08 Sep 2004 11:13:42 +0200
From: Helge Hafting <helge.hafting@hist.no>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tonnerre <tonnerre@thundrix.ch>
CC: Tom Vier <tmv@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
References: <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1093480940.2748.35.camel@entropy> <20040826044425.GL5414@waste.org> <1093496948.2748.69.camel@entropy> <20040826053200.GU31237@waste.org> <412D9FFA.6030307@hist.no> <20040902230526.GB15505@zero> <41382624.7000701@hist.no> <20040905111357.GB26560@thundrix.ch>
In-Reply-To: <20040905111357.GB26560@thundrix.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre wrote:

>Salut,
>
>On Fri, Sep 03, 2004 at 10:07:00AM +0200, Helge Hafting wrote:
>  
>
>>Moving a file doen't move the associated thumbnail, and then you
>>notice something is missing, or don't find the file, or have to wait
>>for regeneration when the app notices a file without a tumb. 
>>That could take some time if you moved a directory full of postscript
>>files, for example.
>>    
>>
>
>That's why the userland file utilities must be aware of the feature..
>  
>
That won't ever happen.  There are many ways of implementing
thumbnails, and people don't want to slow down the operation
of "mv" by having it search for _all_ the known thumbnails schemes.
(Yes - several may be in use simultaneosly because the user uses several
file managers!)  The waste of time is even more interesting for the many
directories that doesn't have thumbs at all.

A file-as-dir implementation of thumbnails avoids this particular
problem.  There are other uses, so I hope people won't see
file-as-dir as a mechanism for "file attributes" _only_.

Helge Hafting



