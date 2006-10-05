Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751282AbWJEUic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751282AbWJEUic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 16:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751284AbWJEUic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 16:38:32 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:25019 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751282AbWJEUia (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 16:38:30 -0400
Date: Thu, 5 Oct 2006 22:37:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Sam Ravnborg <sam@ravnborg.org>
cc: Dennis Heuer <dh@triple-media.com>, linux-kernel@vger.kernel.org
Subject: Re: sunifdef instead of unifdef
In-Reply-To: <20061005192629.GB20742@uranus.ravnborg.org>
Message-ID: <Pine.LNX.4.61.0610052236010.6038@yvahk01.tjqt.qr>
References: <20061005183830.351a0a2f.dh@triple-media.com>
 <20061005192629.GB20742@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> However, there are three main reasons why I pledge for sunifdef
>> compatibility:
>> 
>> 1. There is a project page and an inviting community
>> 2. There is HTML documentation
>> 3. They use autotools, which is distributor and administrator-friendly

autotools is, in some places, not developer friendly. A V=1 feature like 
the kernel's makefile system has would be beneficial, as well as the 
possibility to use PIC-compiled objects for PIE-executables (which 
currently throws an error on some distros, and requires workarounds, 
like the *-nolibtool files in pam_mount)

>> gcc -O2 -m64   -c -o unifdef.o unifdef.c
>> unifdef.c: In function 'main':
>> unifdef.c:129: warning: incompatible implicit declaration of built-in
>> function 'exit'
>> unifdef.c:157: warning: incompatible implicit declaration of built-in
>> function 'exit'
>> unifdef.c:180: warning: incompatible implicit declaration of built-in
>> function 'exit'
>> gcc unifdef.o -o unifdef
>Patches appreciated - seems a simple #include is missing.

#include <stdlib.h>


	-`J'
-- 
