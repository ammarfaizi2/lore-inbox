Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267578AbUIULoe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267578AbUIULoe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 07:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267585AbUIULoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 07:44:34 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:10257 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267578AbUIULoc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 07:44:32 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Pavel Machek <pavel@ucw.cz>, Stas Sergeev <stsp@aknet.ru>
Subject: Re: ESP corruption bug - what CPUs are affected?
Date: Tue, 21 Sep 2004 14:43:37 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <4149D243.5050501@aknet.ru> <414C14CD.7030200@aknet.ru> <20040921111900.GA7515@elf.ucw.cz>
In-Reply-To: <20040921111900.GA7515@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409211443.37854.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 September 2004 14:19, Pavel Machek wrote:
> Hi!
> 
> > >for subsequent push/pop/call/ret operations.
> > >But if code uses full ESP, thinking that upper 16 bits are zero,
> > >it will crash badly. Correct me if I'm wrong.
> >
> > That's correct. But you should note that the
> > program not just "thinks" that the upper 16 bits
> > are zero. It writes zero there itself, and a few
> > instructions later - oops, it is no longer zero...
> 
> Hmm, perhaps this can also be viewed as a "information leak"? Program
> running under dosemu is not expected to know high bits of kernel
> %esp...

Yes.

I must admit that Stas was right and I was wrong.
This is a 386 CPU bug.

Since then it seems to be codified in i86 architecture
and duplicated in all successors.
Incredible... :(
--
vda

