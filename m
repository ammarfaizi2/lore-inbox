Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263336AbTDGIbr (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTDGIbr (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:31:47 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:15059 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263336AbTDGIbq (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 04:31:46 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.14882.696046.660762@laputa.namesys.com>
Date: Mon, 7 Apr 2003 12:43:14 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Christoph Hellwig <hch@infradead.org>
Cc: Nicholas Wourms <dragon@gentoo.org>, Christoph Hellwig <hch@lst.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove kdevname() before someone starts using it again
In-Reply-To: <20030407091923.B28879@infradead.org>
References: <20030331162634.A14319@lst.de>
	<3E908DF6.1050004@gentoo.org>
	<16017.11269.576246.373826@laputa.namesys.com>
	<20030407091923.B28879@infradead.org>
X-Mailer: VM 7.07 under 21.5  (beta11) "cabbage" XEmacs Lucid
X-Emacs-Acronym: Edwardian Manifestation of All Colonial Sins
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:
 > On Mon, Apr 07, 2003 at 11:43:01AM +0400, Nikita Danilov wrote:
 > > Nicholas Wourms writes:
 > >  > 
 > >  > A quick grep shows that Intermezzo FS still uses kdevname if 
 > >  > you've turned on debugging (fs/intermezzo/sysctl.c).  As for 
 > >  > pending stuff, both Reiser4 & pktcdvd also use it.  So I 
 > > 
 > > reiser4 switched to bdevname().
 > 
 > Although bdevname is the simplest replacement it's usually the wrong
 > one.  If you refer to a filesystem with it use sb->s_id, if you refer
 > to a block device you normally want to use partition_name() - it gives
 > much nicer output.

Thank you for the information.

We need something to name per super block directory under
/sys/fs/reiser4. It probably makes sense to have a convention for this
shared by all file systems living on top of block devices, like using
sb->s_id.

 > 

Nikita.
