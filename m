Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268450AbUH3CXi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268450AbUH3CXi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 22:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268449AbUH3CXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 22:23:36 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:58316 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268442AbUH3CXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 22:23:31 -0400
X-Comment: AT&T Maillennium special handling code - c
Message-ID: <41328E6F.60902@namesys.com>
Date: Sun, 29 Aug 2004 19:18:23 -0700
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

You are assuming that the hiding has to be embodied by the dentry cache. 
That sounds hard. Let's not do that; I am too lazy.

We can put it at a layer above that. Let us have a "mask" concept. For 
the purposes of this discussion, the mask can be made totally trivial 
and hardcoded, with none of the expressive power of my new DoD project, 
and can probably be coded in a few hours to exclude the metas. For my 
new DoD project we are creating a configurable, scalable, sophisticated 
"mask" abstraction, and you must successfully pass through the mask 
before you can ask if the filesystem contains X/Y/Z. (For the darpa 
project with the general purpose masks with specifications and all that 
we will take 6 months, not a few hours.)

The rest shall wait until after I get a bite to eat, ok?

Hans

viro@parcelfarce.linux.theplanet.co.uk wrote:

>On Sun, Aug 29, 2004 at 01:06:41PM -0700, Hans Reiser wrote:
>
>  
>
>>How about if you educate me on the problems you see for a bit before I 
>>respond? I think it might help us move into a constructive discussion.
>>    
>>
>
>A slew of cache coherency issues (and memory consumption on top of that).
>Rigth now we have a signle dentry tree for all fs instances, no matter
>how many times it and its subtrees are visible in the tree.  Which,
>obviously, avoids all that crap.  As soon as we start trying to have
>multiple trees over the same fs, we are in for a *lot* of fun.
>
>  
>

