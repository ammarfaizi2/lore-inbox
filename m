Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUIBUWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUIBUWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 16:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUIBUVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 16:21:03 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:42213 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268955AbUIBUSs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 16:18:48 -0400
Date: Thu, 02 Sep 2004 13:16:35 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Spam <spam@tnonline.net>, Steve Bergman <steve@rueb.com>
cc: Hans Reiser <reiser@namesys.com>, Linus Torvalds <torvalds@osdl.org>,
       David Masover <ninja@slaphack.com>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       reiserfs <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
Message-ID: <90660000.1094156195@flay>
In-Reply-To: <16310213029.20040902220603@tnonline.net>
References: <20040826150202.GE5733@mail.shareable.org><200408282314.i7SNErYv003270@localhost.localdomain><20040901200806.GC31934@mail.shareable.org><Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org><20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com><Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org><4136A14E.9010303@slaphack.com><Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org><4136C876.5010806@namesys.com><Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org><4136E0B6.4000705@namesys.com>  <14260000.1094149320@flay><1094154744.12730.64.camel@voyager.localdomain> <16310213029.20040902220603@tnonline.net>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 1. The file as directory thing adds complexity that the administrator
>> has to deal with.  Symlinks are useful, but it's still aggravating to
>> tar off a directory structure, take it somewhere, and then realize that
>> all you have is links to something not in the archive because you didn't
>> get your tar switches just right.  Now we're talking about adding
>> another set of "files which are not really files" to the semantics.
>> More complexity.  I'll take simplicity over some ivory tower ideal of
>> "unified name space" any day.
> 
>   Are you afraid to learn something new? ;) Just joking. But really,
>   it doesn't have to be very difficult. The extra streams etc would
>   just be saved as files. If tar is patched then it would be no
>   problem and no extra stuff but perhaps a switch --save-metas.

If they're saved as files, and the app has to be changed to use them
anyway, then what's the point? Just change the app to use new files
instead.

>   I would agree with tunnel vision. The kernel should provide the
>   tools and options. Users and developers can then invent new things
>   to use them. :)

Ugh. Change for changes sake is not a good thing. There's enough real
problems in the world without inventing random features. More complexity
without gain is a Bad Thing (tm).

I'm not saying streams is bad ... just that there don't seem to have
been very many convincing (to me) arguments raised for it yet. The 
versioning stuff would be nice, IMHO, because the stuff mainly using it 
wouldn't need to be modified in many instances ... "vi /etc/configfile" 
would keep old copies for you (only the recovery tool would need to
understand it). Saving icons seems easy enough to do with "foo.icon"
as another file.

M.

