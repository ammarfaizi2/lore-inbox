Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268979AbTCASE0>; Sat, 1 Mar 2003 13:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268980AbTCASE0>; Sat, 1 Mar 2003 13:04:26 -0500
Received: from verein.lst.de ([212.34.181.86]:5900 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S268979AbTCASEZ>;
	Sat, 1 Mar 2003 13:04:25 -0500
Date: Sat, 1 Mar 2003 19:14:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] die kdevname(), die!
Message-ID: <20030301191441.A2185@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	linux-kernel@vger.kernel.org
References: <20030301190355.A1900@lst.de> <Pine.LNX.4.44.0303011009510.16800-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0303011009510.16800-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Mar 01, 2003 at 10:10:23AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 01, 2003 at 10:10:23AM -0800, Linus Torvalds wrote:
> 
> I really think that replacing "kdevname()" with "__bdevname()" is a step 
> in the wrong direction (or at least sideways).

kdevname() is the really wrong interface because it doesn't know whether
we have a character or block device.  __bdevname is a bit better because
it's block-device specific.  It's not perfect yet, though.

