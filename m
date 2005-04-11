Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261956AbVDKVlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbVDKVlq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 17:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbVDKVlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 17:41:46 -0400
Received: from mail.shareable.org ([81.29.64.88]:53407 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261949AbVDKVlm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 17:41:42 -0400
Date: Mon, 11 Apr 2005 22:41:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: dan@debian.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050411214123.GF32535@mail.shareable.org>
References: <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411153619.GA25987@nevyn.them.org> <E1DL1Gj-000091-00@dorka.pomaz.szeredi.hu> <20050411181717.GA1129@nevyn.them.org> <E1DL4J4-0000Py-00@dorka.pomaz.szeredi.hu> <20050411192223.GA3707@nevyn.them.org> <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DL51J-0000To-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
> That is exactly the intended effect.  If I'm at my work machine (where
> I'm not an admin unfortunately) and I mount my home machine with sshfs
> (because FUSE is installed fortunately :), then I bloody well don't
> want the sysadmin or some automated script of his to go mucking under
> the mountpoint.

I think that would be _much_ nicer implemented as a mount which is
invisible to other users, rather than one which causes the admin's
scripts to spew error messages.  Is the namespace mechanism at all
suitable for that?

It would also be nice to generalise and have virtual filesystems which
are able to present different views to different users.  Can FUSE do
that already - is the userspace part told which user is doing each
operation?  With that, the desire for virtual filesystems which cannot
be read by your sysadmin (by accident) is easy to satisfy - and that
kind of mechanism would probably be acceptable to all.

-- Jamie
