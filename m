Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262167AbUCEDU1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 22:20:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262174AbUCEDU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 22:20:27 -0500
Received: from ms-smtp-02-smtplb.ohiordc.rr.com ([65.24.5.136]:13193 "EHLO
	ms-smtp-02-eri0.ohiordc.rr.com") by vger.kernel.org with ESMTP
	id S262167AbUCEDU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 22:20:26 -0500
From: Rob Couto <rpc@cafe4111.org>
Reply-To: rpc@cafe4111.org
Organization: Cafe 41:11
To: Billy Rose <billyrose@cox-internet.com>
Subject: Re: kernel mode console
Date: Thu, 4 Mar 2004 22:20:00 -0500
User-Agent: KMail/1.6
References: <200403022152.06950.billyrose@cox-internet.com> <200403040942.23176.krishnakumar@naturesoft.net> <200403041858.45617.billyrose@cox-internet.com>
In-Reply-To: <200403041858.45617.billyrose@cox-internet.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403042220.00046.rpc@cafe4111.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 March 2004 07:58 pm, you wrote:
> i think perhaps i need to expound upon what i have a vision of. a kernel
> mode console is just that: a console designed to run in kernel mode. it
> could have built in commands to allow for quick and dirty examination of
> stuff (anything really, like memory dumps) and a command processor for
> scripted stuff, but the true power of it comes in when you issue a command
> that is not internal to the console. it could run a special debugger, an
> application that installs a probe, a memory monitor, etc., etc. in short it
> is not a debugger per-say, but a "god mode" console for the linux kernel.
> that is what i had a vision of. the executables it would run would
> necessarily be compiled for that. again, i ask is that worth the time
> coding it?

a kbash? ksh is taken... kash would become instantly confusing to some 
english-speakers... fun for some, but others would hear it and think 'cache' 
and immediately be thrown out of sync ;)

you could extend proc (or is it just sys?) that way, creating files that can 
trigger events ('echo (desired range) > /proc/sh/memdump/range', 'echo 1 
> /proc/sh/memdump/go' or even simply 'cat /proc/sh/memdump/out' after 
inputting range) and stick with the cat/echo control... some of your 
userspace shell's commands could simply be wrappers for ordinary 'echo foo 
> /proc/foo' already

OTOH, someone said proc's been abused already, having it do things that aren't 
its job and causing disorganization in the kernel. i dunno, that's why im not 
in charge

-- 
Rob Couto
rpc@cafe4111.org
Rules for computing success:
1) Attitude is no substitute for competence.
2) Ease of use is no substitute for power.
3) Safety matters; use a static-free hammer.
--
