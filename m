Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261541AbSKNE1u>; Wed, 13 Nov 2002 23:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262430AbSKNE1t>; Wed, 13 Nov 2002 23:27:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5639 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261541AbSKNE1t>;
	Wed, 13 Nov 2002 23:27:49 -0500
Message-ID: <3DD327BF.4040705@pobox.com>
Date: Wed, 13 Nov 2002 23:34:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Modules and the Interfaces who Love Them (Take I)
References: <20021114032456.5676D2C0C9@lists.samba.org>
In-Reply-To: <20021114032456.5676D2C0C9@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:

> Slow: Your approach where every interface has to do reference counts
> even though they're only useful for modules makes every interface
> slow, whether they are using modules or not.  You can't make them
> fast, because that would make every interface NR_CPUS *
> sizeof(cacheline) larger.


(tangent alert)

Objects controlled by interfaces typically should be ref-counted... 
life in the kernel is slowly getting better WRT this, but we're not 
there yet.  In any case, the ref counts help, not hurt.

	Jeff



