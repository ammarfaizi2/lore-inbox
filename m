Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264677AbSKNEKc>; Wed, 13 Nov 2002 23:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264702AbSKNEKc>; Wed, 13 Nov 2002 23:10:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30213 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264677AbSKNEKb>;
	Wed, 13 Nov 2002 23:10:31 -0500
Message-ID: <3DD323B4.6080404@pobox.com>
Date: Wed, 13 Nov 2002 23:16:52 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Module parameters reimplementation 0/4
References: <20021114032456.3337E2C057@lists.samba.org>
In-Reply-To: <20021114032456.3337E2C057@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> Finally, if you do not use your own types, PARAM() can be #defined
> into a MODULE_PARM statement for 2.4 kernels (ie. backwards
> compatible).  Patch 4/4 also translates old-style MODULE_PARM() into
> PARAMs at load time, for existing modules.



Let's be more friendly to the namespace and call it something less 
ambiguous, like MODULE_PARAM, even if that might not be strictly true in 
1% of the cases.  IMO there are certainly valid local uses of 'PARAM' in 
kernel code.

You can see from the totally gratuitous patch to 
include/asm-i386/setup.h which should have been a clue...

If this was C++ we could just stick PARAM in the "rusty" namespace and 
be done with it, but such as things are......  ;-)

	Jeff



