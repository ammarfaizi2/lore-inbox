Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262219AbVCBITG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262219AbVCBITG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 03:19:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262220AbVCBITG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 03:19:06 -0500
Received: from colin2.muc.de ([193.149.48.15]:31500 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S262219AbVCBIS7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 03:18:59 -0500
Date: 2 Mar 2005 09:18:58 +0100
Date: Wed, 2 Mar 2005 09:18:58 +0100
From: Andi Kleen <ak@muc.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Bernd Schubert <bernd-schubert@web.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       trond.myklebust@fys.uio.no
Subject: Re: x86_64: 32bit emulation problems
Message-ID: <20050302081858.GA7672@muc.de>
References: <200502282154.08009.bernd.schubert@pci.uni-heidelberg.de> <200503012207.02915.bernd-schubert@web.de> <jewtsruie9.fsf@sykes.suse.de> <200503020019.20256.bernd-schubert@web.de> <jebra3udyo.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jebra3udyo.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2005 at 12:46:23AM +0100, Andreas Schwab wrote:
> Bernd Schubert <bernd-schubert@web.de> writes:
> 
> > Hmm, after compiling with -D_FILE_OFFSET_BITS=64 it works fine. But why does 
> > it work without this option on a 32bit kernel, but not on a 64bit kernel?
> 
> See nfs_fileid_to_ino_t for why the inode number is different between
> 32bit and 64bit kernels.

Ok that explains it. Thanks.

Best would be probably to just do the shift unconditionally on 64bit kernels
too.

Trond, what do you think?

-Andi
