Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266879AbUH3Hrc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266879AbUH3Hrc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 03:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267285AbUH3Hrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 03:47:31 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:39421 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266879AbUH3HrV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 03:47:21 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <4132DA55.5080903@namesys.com>
Date: Mon, 30 Aug 2004 00:42:13 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: viro@parcelfarce.linux.theplanet.co.uk
CC: flx@msu.ru, Paul Jackson <pj@sgi.com>, riel@redhat.com, ninja@slaphack.com,
       torvalds@osdl.org, diegocg@teleline.es, jamie@shareable.org,
       christophe@saout.de, vda@port.imtp.ilyichevsk.odessa.ua,
       christer@weinigel.se, spam@tnonline.net, akpm@osdl.org,
       wichert@wiggy.net, jra@samba.org, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4 
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com> <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com> <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com> <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk> <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com> <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think we have to either:

1) Link only to the file and not the directory in the file-directory 
duality. This means we change the semantics of hard link so that it only 
links to the data and the standard metadata, and the optional 
attributes/streams/files-in-directory are not seen by the second link. 
You can think of this as meaning that hard links only connect to the 
file and not the directory in the file-directory wave-particle duality

or, 2) we should ask Alexander Smith to help with applying the graph 
traversal cycle detection code that he wrote.

I can go either way contentedly for now. 2) is the right long term 
solution. 1) is probably the right short term solution.

Ok, Linus and Viro, now I see why it was hard. Being able to effectively 
connect to compound documents only with symlinks is a bit distasteful, 
but it is quite livable, and I very much hope you decide it is better 
than fragmenting the namespace.

Hans



