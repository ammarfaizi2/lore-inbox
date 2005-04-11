Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVDKPgm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVDKPgm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 11:36:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261814AbVDKPgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 11:36:41 -0400
Received: from nevyn.them.org ([66.93.172.17]:11745 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261812AbVDKPgZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 11:36:25 -0400
Date: Mon, 11 Apr 2005 11:36:19 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050411153619.GA25987@nevyn.them.org>
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@infradead.org, akpm@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <20050323083347.GA1807@infradead.org> <E1DE2D1-0005Ie-00@dorka.pomaz.szeredi.hu> <20050325095838.GA9471@infradead.org> <E1DEmYC-0008Qg-00@dorka.pomaz.szeredi.hu> <20050331112427.GA15034@infradead.org> <E1DH13O-000400-00@dorka.pomaz.szeredi.hu> <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 04:43:32PM +0200, Miklos Szeredi wrote:
>   3) No other user should have access to files under the mount, not
>      even root[5]

> [5] Obviously root cannot be restricted, but accidental access to
> private data is still a good idea.  E.g. root squashing by NFS servers
> has a similar affect.

Could you explain a little more?  I don't see the point in denying
access to root, but I also can't tell from your explanation whether you
do or not.

If I mount a filesystem using ssh, I want to be able to "sudo cp
foo.txt /etc" and not get an inexplicable permissions error.

I don't really see the point of this restriction, anyway.  Could you
explain why this shouldn't be a matter of policy, and kept out of the
kernel?  Have the userspace file servers default to putting restrictive
permissions on mounts unless requested otherwise.

I can think of plenty of uses for this.

>   4) Access should not be further restricted for the owner of the
>      mount, even if permission bits, uid or gid would suggest
>      otherwise

Similar questions.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
