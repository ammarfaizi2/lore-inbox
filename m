Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272574AbRHaBLs>; Thu, 30 Aug 2001 21:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272575AbRHaBLi>; Thu, 30 Aug 2001 21:11:38 -0400
Received: from rj.sgi.com ([204.94.215.100]:42985 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S272574AbRHaBL1>;
	Thu, 30 Aug 2001 21:11:27 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <laughing@shared-source.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac5 
In-Reply-To: Your message of "Fri, 31 Aug 2001 01:33:11 +0100."
             <20010831013311.A8535@lightning.swansea.linux.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 31 Aug 2001 11:11:33 +1000
Message-ID: <8483.999220293@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2001 01:33:11 +0100, 
Alan Cox <laughing@shared-source.org> wrote:
>2.4.9-ac5
>o	Add MODULE_LICENSE tagging			(me)

__module_license needs to be static.  Otherwise we get problems when
MODULE_LICENSE() is used in two objects which are linked into the same
module.  Given the legal requirements for copyright etc., I expect
people to put MODULE_LICENSE in every source file, not just one.

What do you need for licence support in modutils?  Obviously modinfo
needs to print it, but what about insmod?  Should insmod issue warning
messages for proprietary modules?  What about ksymoops?  IOW, what was
the reason for adding MODULE_LICENSE?

