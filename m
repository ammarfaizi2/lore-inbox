Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315265AbSFDRKj>; Tue, 4 Jun 2002 13:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315264AbSFDRJw>; Tue, 4 Jun 2002 13:09:52 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:42503 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S315265AbSFDRJs>; Tue, 4 Jun 2002 13:09:48 -0400
Date: Tue, 4 Jun 2002 19:00:07 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.20 RAID5 compile error
Message-ID: <20020604190007.Q681@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <04cf01c20b2d$96097030$f6de11cc@black> <20020604115132.GZ1105@suse.de> <15612.43734.121255.771451@notabene.cse.unsw.edu.au> <20020604115842.GA5143@suse.de> <15612.44897.858819.455679@notabene.cse.unsw.edu.au> <20020604122105.GB1105@suse.de> <20020604123205.GD1105@suse.de> <20020604123856.GE1105@suse.de> <20020604142327.GN1105@suse.de> <3CFCC467.7060702@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,
Hi Jens,
Hi LKML,

On Tue, Jun 04, 2002 at 03:45:11PM +0200, Martin Dalecki wrote:
> Jens - I have noticed some unlikely() tag "optimizations" in
> tcq code too.

unlikely() shows the reader immediately that this is (considered)
a "rare" condition. This might stop janitors optimizing these
cases at all or let people with deeper knowledge check, whether
this is REALLY rare. 

likely() should lead to the analogous actions.

So this is not only a hint for the compiler and I'm very happy to
see this being used and can stand the code clutter caused by
this ;-)

OTOH your point about inline is very valid. I use it only for
code splitting or trivial functions with decisions on compile
time constants. Everything else just bloats the *.o files.

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
