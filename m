Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264941AbSJVUkq>; Tue, 22 Oct 2002 16:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264943AbSJVUkq>; Tue, 22 Oct 2002 16:40:46 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:39587 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S264941AbSJVUkp>;
	Tue, 22 Oct 2002 16:40:45 -0400
Date: Tue, 22 Oct 2002 22:46:44 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: erich@uruk.org
Cc: David Grothe <dave@gcom.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: I386 cli
Message-ID: <20021022224644.A25463@ucw.cz>
References: <5.1.0.14.2.20021022145759.02861ec8@localhost> <E1845KV-0002ab-00@trillium-hollow.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E1845KV-0002ab-00@trillium-hollow.org>; from erich@uruk.org on Tue, Oct 22, 2002 at 01:08:43PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 22, 2002 at 01:08:43PM -0700, erich@uruk.org wrote:

> David Grothe <dave@gcom.com> wrote:
> 
> > In 2.5.41every architecture except Intel 386 has a "#define cli 
> > <something>" in its asm-arch/system.h file.  Is there supposed to be such a 
> > define in asm-i386/system.h?  If not, where does the "official" definition 
> > of cli() live for Intel?  Or what is the include file that one needs to 
> > pick it up?  I can't find it.
> 
> I'm sure there is no definition because "cli" is the native assembler
> instruction on x86.

Wrong reason. Furthermore, cli(), meaning 'global interrupt disable,
across all processors', is not doable with a single instruction anyway.
It's not defined, because it should not be used - usually the usage of
cli() means a bug.

-- 
Vojtech Pavlik
SuSE Labs
