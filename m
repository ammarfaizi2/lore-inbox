Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265709AbUATVHZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:07:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265713AbUATVHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:07:24 -0500
Received: from pooh.lsc.hu ([195.56.172.131]:7065 "EHLO pooh.lsc.hu")
	by vger.kernel.org with ESMTP id S265709AbUATVHX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:07:23 -0500
Date: Tue, 20 Jan 2004 21:52:01 +0100
From: GCS <gcs@lsc.hu>
To: Valdis.Kletnieks@vt.edu
Cc: Andrew Morton <akpm@osdl.org>, helgehaf@aitel.hist.no,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-mm5 dies booting, possibly network related
Message-ID: <20040120205201.GA17026@lsc.hu>
References: <20040120000535.7fb8e683.akpm@osdl.org> <400D083F.6080907@aitel.hist.no> <20040120175408.GA12805@lsc.hu> <20040120102302.47fa26cd.akpm@osdl.org> <200401201853.i0KIrS6Z025026@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200401201853.i0KIrS6Z025026@turing-police.cc.vt.edu>
X-Operating-System: GNU/Linux
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 01:53:28PM -0500, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Tue, 20 Jan 2004 10:23:02 PST, Andrew Morton said:
> 
> > So yes, whatever compiler you are using, turn off CONFIG_REGPARM - it is
> > still very experimental.
 It's not CONFIG_REGPARM :-(, I have turned it off, recompiled, reboot
-> same effect (it seems the list dropped my mail with bootlog, should I
resend it to the list with gzip compression?).
 If someone can help me what patches should I revert, I would be happy
to help OTOH.

> > (And of dubious value - it only saved me 0.6% of program text).
 It was for experiencing only, but I see it's not for real value. :-|

> I wonder if this is because the x86 architecture is relatively
> register-starved,
 I have started on Sun's SparcStaion (LX actually), and I like RISC
processors much more since then. :-)

> and as a result, we pass the parameters in registers, but the
> first thing the function has to do is store half of them on the stack so it has
> enough free registers to work with.  If this is the case then regparm(1) or
> regparm(2) may do better/worse by changing how much register pressure the
> function starts off with.
 Yup, that can be the reason why Andrew saw only 0.6% save on program text.

Cheers,
GCS
