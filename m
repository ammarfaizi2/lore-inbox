Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287011AbSABWHo>; Wed, 2 Jan 2002 17:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286853AbSABWHZ>; Wed, 2 Jan 2002 17:07:25 -0500
Received: from [217.9.226.246] ([217.9.226.246]:36480 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S284886AbSABWHO>; Wed, 2 Jan 2002 17:07:14 -0500
To: Andrew Morton <akpm@zip.com.au>
Cc: Oliver Xymoron <oxymoron@waste.org>,
        vda <vda@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: Extern variables in *.c files
In-Reply-To: <02010216180403.01928@manta>
	<Pine.LNX.4.43.0201021322120.30079-100000@waste.org>
	<3C337EF1.4C7C72AB@zip.com.au>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <3C337EF1.4C7C72AB@zip.com.au>
Date: 03 Jan 2002 00:07:18 +0200
Message-ID: <87ell8wgo9.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@zip.com.au> writes:

Andrew> Oliver Xymoron wrote:
>> 
>> On Wed, 2 Jan 2002, vda wrote:
>> 
>> > I grepped kernel *.c (not *.h!) files for extern variable definitions.
>> > Much to my surprize, I found ~1500 such defs.
>> >
>> > Isn't that bad C code style? What will happen if/when type of variable gets
>> > changed? (int->long).
>> 
>> Yes; Int->long won't change anything on 32-bit machines and will break
>> silently on 64-bit ones. The trick is finding appropriate places to put
>> such definitions so that all the things that need them can include them
>> without circular dependencies.
>> 

Andrew> Isn't there some way to get the linker to detect the differing
Andrew> sizes?
`--warn-common'
     Warn when a common symbol is combined with another common symbol
     or with a symbol definition.  Unix linkers allow this somewhat
     sloppy practice, but linkers on some other operating systems do
     not.  This option allows you to find potential problems from
     combining global symbols.  Unfortunately, some C libraries use
     this practice, so you may get some warnings about symbols in the
     libraries as well as in your programs.

Regards,
-velco

