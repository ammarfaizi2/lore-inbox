Return-Path: <linux-kernel-owner+w=401wt.eu-S1030314AbWLTTzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030314AbWLTTzB (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 14:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWLTTzB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 14:55:01 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:40949 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030314AbWLTTzA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 14:55:00 -0500
Date: Wed, 20 Dec 2006 19:54:58 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: mikulas@artax.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: Finding hardlinks
Message-ID: <20061220195458.GH17561@ftp.linux.org.uk>
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz> <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.64.0612201732040.6115@artax.karlin.mff.cuni.cz> <E1Gx4dv-00058S-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1Gx4dv-00058S-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 20, 2006 at 05:50:11PM +0100, Miklos Szeredi wrote:
> I don't see any problems with changing struct kstat.  There would be
> reservations against changing inode.i_ino though.
> 
> So filesystems that have 64bit inodes will need a specialized
> getattr() method instead of generic_fillattr().

And they are already free to do so.  And no, struct kstat doesn't need
to be changed - it has u64 ino already.
