Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUJHUmv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUJHUmv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 16:42:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUJHUmv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 16:42:51 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:23815 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S264668AbUJHUmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 16:42:49 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: [PATCH] Make gcc -align options .config-settable
Date: Fri, 8 Oct 2004 23:42:40 +0300
User-Agent: KMail/1.5.4
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
References: <2KBq9-2S1-15@gated-at.bofh.it> <200410081710.58766.vda@port.imtp.ilyichevsk.odessa.ua> <Pine.LNX.4.60.0410081618530.10253@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.60.0410081618530.10253@alpha.polcom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410082342.40682.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 October 2004 17:30, Grzegorz Kulewski wrote:
> > Also bencmarking people may do little research on real usefulness of
> > various kinds of alignment.
> 
> I think that removing aligns completly will be very bad. I am Gentoo user 
> and I set my user space CFLAGS for all system to -falign-loops 
> -fno-align-<everything else>. I did not tested it in depth, but my simple 
> tests show that unaligning loops is a very bad idea. Unaligning functions 

That depends on how often that loop runs. 90% of code runs only
10% of time. I think ultimately we want to mark other 10% of code with:

int __hotpath often_called_func()
{
...
}

Rest of code is to be optimized for size.

> is safer since small and fast functions should be always inlined.

Concept of alignment does not apply to inlined functions at all.
--
vda

