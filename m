Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263675AbRFMOEk>; Wed, 13 Jun 2001 10:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263674AbRFMOEa>; Wed, 13 Jun 2001 10:04:30 -0400
Received: from firewall.ocs.com.au ([203.34.97.9]:59891 "EHLO ocs4.ocs-net")
	by vger.kernel.org with ESMTP id <S263752AbRFMOEN>;
	Wed, 13 Jun 2001 10:04:13 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: Your message of "Wed, 13 Jun 2001 09:48:33 -0400."
             <3B276F31.8BBF06AF@mandrakesoft.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 14 Jun 2001 00:03:52 +1000
Message-ID: <10072.992441032@ocs4.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Jun 2001 09:48:33 -0400, 
Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
>"David S. Miller" wrote:
>> It can get preprocessed if you know how.  Simply use the "i" asm
>> constraint for an extra argument, and use the symbol there.
>
>how to do this in foo.S code?

Fortunately it is not a problem for foo.S code - yet.  External symbol
references only need module version pre-processing when the code is in
a module.  AFAIK no *.S code is compiled into a module, all *.S code is
built into vmlinux, this is why I did not use this argument myself.
OTOH if any *.S code is compiled into a module then all symbols it
refers to must be EXPORT_SYMBOL_NOVERS().

