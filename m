Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265946AbUGZVNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265946AbUGZVNz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 17:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUGZVMj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 17:12:39 -0400
Received: from thunk.org ([140.239.227.29]:7066 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266075AbUGZVEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 17:04:55 -0400
Date: Mon, 26 Jul 2004 15:57:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: ext3 and SPEC SFS Run rules.
Message-ID: <20040726195716.GB8144@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Tigran Aivazian <tigran@aivazian.fsnet.co.uk>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040726000313.3fbf8403.akpm@osdl.org> <Pine.LNX.4.44.0407261010400.32233-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0407261010400.32233-100000@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 26, 2004 at 10:12:01AM +0100, Tigran Aivazian wrote:
> On Mon, 26 Jul 2004, Andrew Morton wrote:
> > ext3 should be fully syncing data and metadata for both fsync() and O_SYNC
> > writes in all three journalling modes.  If not, that's a big bug.
> 
> Ok, so, can I conclude that you are therefore saying that ext3 (with 
> default mount options) is compliant with SPEC SFS Run rules wrt NFS 
> protocol requirements:

This is up to the NFS server, not to the underlying filesystem.  It
would be insane for every single local write() to have mandatory
O_SYNC semantics, even if it is required by the NFS protocol.  

In modern Linux implementations of the NFS server, you can specify
whether or not the synchronization semantics as demanded by the NFS
protocol, or whether the more relaxed async writebacks are done.
Obviously, this has some pretty serious performance vs robustness
implications.

						- Ted
