Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131092AbRCGQKt>; Wed, 7 Mar 2001 11:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131088AbRCGQKj>; Wed, 7 Mar 2001 11:10:39 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:44815 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S131104AbRCGQK2>;
	Wed, 7 Mar 2001 11:10:28 -0500
Date: Wed, 7 Mar 2001 17:10:20 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Hashing and directories
Message-ID: <20010307171020.A10607@pcep-jamie.cern.ch>
In-Reply-To: <000201c0a71f$3a48fae0$5517fea9@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <000201c0a71f$3a48fae0$5517fea9@local>; from manfred@colorfullife.com on Wed, Mar 07, 2001 at 04:56:36PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> I'm not sure that this is the right way: It means that every exec() must
> call dup_mmap(), and usually only to copy a few hundert bytes. But I
> don't see a sane alternative. I won't propose to create a temporary file
> in a kernel tmpfs mount ;-)

Every exec creates a whole new mm anyway, after copying data from the
old mm.  The suggestion is to create the new mm before copying the data,
and to copy the data from the old mm directly to the new one.

-- Jamie
