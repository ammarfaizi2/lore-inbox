Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266876AbUIORVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266876AbUIORVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 13:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266892AbUIORTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 13:19:04 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:26885 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266878AbUIORRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 13:17:24 -0400
Message-ID: <41487A7A.80107@techsource.com>
Date: Wed, 15 Sep 2004 13:23:06 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Linus Torvalds <torvalds@osdl.org>, David Masover <ninja@slaphack.com>,
       Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: The argument for fs assistance in handling archives
References: <20040826150202.GE5733@mail.shareable.org> <200408282314.i7SNErYv003270@localhost.localdomain> <20040901200806.GC31934@mail.shareable.org> <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org> <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com> <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org> <4136A14E.9010303@slaphack.com> <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org> <4136C876.5010806@namesys.com> <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org> <4136E0B6.4000705@namesys.com>
In-Reply-To: <4136E0B6.4000705@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hey, you know how device nodes have a bit set, indicating that they're 
device nodes and not regular files?  Can a set of such properties be 
defined for reiser4 metadata properties?

Like a "metadata" bit so you can distinguish (if you wish) between 
regular files and metadata objects, and in addition an "archivable 
metadata" bit which indicates that the given piece of metadata is not 
automatically generated and should be archived during backup (some 
manually-generated metadata which does not need to be backed up will not 
have this bit set -- perhaps add another flag indicating that it's not 
automatic but unnecessary to archive).

