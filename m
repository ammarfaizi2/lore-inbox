Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291231AbSAaSsU>; Thu, 31 Jan 2002 13:48:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291232AbSAaSsK>; Thu, 31 Jan 2002 13:48:10 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:25475 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S291231AbSAaSrz>;
	Thu, 31 Jan 2002 13:47:55 -0500
Date: Thu, 31 Jan 2002 13:47:53 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        pavel@atrey.karlin.mff.cuni.cz
Subject: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does not work, and can cause severe damage when read-write)
Message-ID: <20020131134753.E32321@havoc.gtf.org>
In-Reply-To: <20020131132446.GA23990@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131132446.GA23990@vana.vc.cvut.cz>; from vandrove@vc.cvut.cz on Thu, Jan 31, 2002 at 02:24:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 02:24:46PM +0100, Petr Vandrovec wrote:
>     I've got strange idea and tried to build diskless machine around
> 2.5.3... Besides problem with segfaulting crc32 (it is initialized after 
> net/ipv4/ipconfig.c due to lib/lib.a being a library... I had to hardcode
> lib/crc32.o before --start-group in main Makefile, but it is another
> story)

Would you be willing to cook up a patch for this problem?

I ran into this too.  It was solved by setting CONFIG_CRC32=n and
letting the Makefile rules pull it in...  but lib/lib.a needs to be
lib/lib.o really.

	Jeff



