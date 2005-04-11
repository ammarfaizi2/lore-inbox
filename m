Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261871AbVDKS1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261871AbVDKS1c (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 14:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVDKS1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 14:27:31 -0400
Received: from nevyn.them.org ([66.93.172.17]:51137 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261871AbVDKS11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 14:27:27 -0400
Date: Mon, 11 Apr 2005 14:27:25 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk
Subject: Re: [RFC] FUSE permission modell (Was: fuse review bits)
Message-ID: <20050411182725.GA1788@nevyn.them.org>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
	viro@parcelfarce.linux.theplanet.co.uk
References: <E1DE2D1-0005Ie-00@dorka.pomaz.szeredi.hu> <20050325095838.GA9471@infradead.org> <E1DEmYC-0008Qg-00@dorka.pomaz.szeredi.hu> <20050331112427.GA15034@infradead.org> <E1DH13O-000400-00@dorka.pomaz.szeredi.hu> <20050331200502.GA24589@infradead.org> <E1DJsH6-0004nv-00@dorka.pomaz.szeredi.hu> <20050411114728.GA13128@infradead.org> <E1DL08S-0008UH-00@dorka.pomaz.szeredi.hu> <20050411182257.GC32535@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411182257.GC32535@mail.shareable.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 07:22:57PM +0100, Jamie Lokier wrote:
> >   1) Only allow mount over a directory for which the user has write
> >      access (and is not sticky)
> 
> Seems good - but why not sticky?  Mounting a user filesystem in
> /tmp/user-xxx/my-mount-point seems not unreasonable - provided the
> administrator can delete the directory (which is possible with
> detachable mount points).

Because then they could mount over /tmp.  "and (is not sticky || is
owned by the user)" may be more appropriate.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
