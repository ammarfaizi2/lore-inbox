Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269990AbUJHOKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269990AbUJHOKk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 10:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269996AbUJHOKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 10:10:40 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:22544 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269990AbUJHOJW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 10:09:22 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] Make gcc -align options .config-settable
Date: Fri, 8 Oct 2004 17:10:58 +0000
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <2KBq9-2S1-15@gated-at.bofh.it> <m3pt3t9zaj.fsf@averell.firstfloor.org>
In-Reply-To: <m3pt3t9zaj.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200410081710.58766.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2004 12:20, Andi Kleen wrote:
> Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> > Resend.
> >
> > With all alignment options set to 1 (minimum alignment),
> > I've got 5% smaller vmlinux compared to one built with
> > default code alignment.
> >
> > Rediffed against 2.6.9-rc3.
> > Please apply.
>
> I agree with the basic idea (the big alignments also always annoy
> me when I look at disassembly), but I think your CONFIG options
> are far too complicated. I don't think anybody will go as far as
> to tune loops vs function calls.
>
> I would just do a single CONFIG_NO_ALIGNMENTS that sets everything to
> 1, that should be enough.

For me, yes, but there are people which are slightly less obsessed
with code size than me.

They might want to say "try to align to 16 bytes if
it costs less than 5 bytes" etc.

Also bencmarking people may do little research on real usefulness of
various kinds of alignment.
-- 
vda
