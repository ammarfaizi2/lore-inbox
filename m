Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTBMIKA>; Thu, 13 Feb 2003 03:10:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267992AbTBMIKA>; Thu, 13 Feb 2003 03:10:00 -0500
Received: from angband.namesys.com ([212.16.7.85]:28552 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267227AbTBMIKA>; Thu, 13 Feb 2003 03:10:00 -0500
Date: Thu, 13 Feb 2003 11:19:50 +0300
From: Oleg Drokin <green@namesys.com>
To: Jeff Dike <jdike@karaya.com>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.60
Message-ID: <20030213111950.A1369@namesys.com>
References: <200302130412.XAA05507@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200302130412.XAA05507@ccure.karaya.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Feb 12, 2003 at 11:12:38PM -0500, Jeff Dike wrote:
 
> The only other solution I see is to rename the kernel sigprocmask.  Oleg Drokin
> has done with this with a 
> 	-Dsigprocmask=__sigprocmask
> on kernel code compiles, and I've done it at link time with objcopy.  This 

This is a bit incorrect.
I do -Dsigprocmask=__sigprocmask on user code part of UML. I found that glibc
(at least the one I have) defines sigprocmask as weak symbol, but there is
__sigprocmask already that has same address as sigprocmask.
Also this does not work for dynamic build for some reason.

> Anyway, if there's something better, I really want to know about it.

Yeah, someone please come up with the better way. Please!

Bye,
    Oleg
