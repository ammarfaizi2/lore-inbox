Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318139AbSHQTNI>; Sat, 17 Aug 2002 15:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318138AbSHQTNH>; Sat, 17 Aug 2002 15:13:07 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:61944 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318139AbSHQTNG>; Sat, 17 Aug 2002 15:13:06 -0400
Date: Sat, 17 Aug 2002 15:17:04 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] reduce stack usage of sanitize_e820_map
Message-ID: <20020817151704.A3894@redhat.com>
References: <20020815174825.F29874@redhat.com> <m11y8xqu98.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <m11y8xqu98.fsf@frodo.biederman.org>; from ebiederm@xmission.com on Sat, Aug 17, 2002 at 11:18:11AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 11:18:11AM -0600, Eric W. Biederman wrote:
> Benjamin LaHaise <bcrl@redhat.com> writes:
> 
> > Hello,
> > 
> > Currently, sanitize_e820_map uses 0x738 bytes of stack.  The patch below 
> > moves the arrays into __initdata, reducing stack usage to 0x34 bytes.
> 
> Can we keep the arrays in sanitize_e820_map and just mark then static
> and __initdata?  That would appear to be a cleaner solution.   
> Polluting the global kernel name space with these is not nice. 

Nope.  static conflicts with __initdata.  If namespace pollution is a 
concern, just prefix them with e820_.

		-ben
-- 
"You will be reincarnated as a toad; and you will be much happier."
