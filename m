Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269728AbUHZVhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269728AbUHZVhi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 17:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269720AbUHZVh1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 17:37:27 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:3332 "EHLO
	kerberos.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S269725AbUHZVfA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 17:35:00 -0400
From: Felipe Alfaro Solana <lkml@felipe-alfaro.com>
To: Jamie Lokier <jamie@shareable.org>
Subject: Re: silent semantic changes with reiser4
Date: Thu, 26 Aug 2004 23:34:37 +0200
User-Agent: KMail/1.7
Cc: James Bruce <bruce@andrew.cmu.edu>, Andrew Morton <akpm@osdl.org>,
       Spam <spam@tnonline.net>, wichert@wiggy.net, jra@samba.org,
       torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
References: <20040825163225.4441cfdd.akpm@osdl.org> <412E0AC9.2020203@andrew.cmu.edu> <20040826165818.GN5733@mail.shareable.org>
In-Reply-To: <20040826165818.GN5733@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408262334.38791.lkml@felipe-alfaro.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 August 2004 18:58, Jamie Lokier wrote:
> James Bruce wrote:
> > moving 1MB of attributes/streams just to change a 20 character
> > author attribute seems a bit silly.
>
> That's what we do now.  Try editing an MP3's id tags.

What's the problem? Let's say a file has three streams/forks/whatever: the 
unnamed one, and two additional named. The filesystem can treat these three 
streams like three independent (but related) files on disk so, if the author 
attribute belongs to the first named stream, only the first named stream (and 
its corresponding file on the backend) would need to be modified. No need to 
move MBs of data around.
