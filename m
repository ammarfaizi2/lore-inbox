Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262972AbTDBMAq>; Wed, 2 Apr 2003 07:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262974AbTDBMAq>; Wed, 2 Apr 2003 07:00:46 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:34824 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S262972AbTDBMAp>; Wed, 2 Apr 2003 07:00:45 -0500
Date: Wed, 2 Apr 2003 14:11:39 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Keith Owens <kaos@ocs.com.au>
cc: Rusty Russell <rusty@rustcorp.com.au>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Put all functions in kallsyms 
In-Reply-To: <6572.1049158014@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.44.0304021406140.12110-100000@serv>
References: <6572.1049158014@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 1 Apr 2003, Keith Owens wrote:

> Don't.  Almost all kernel threads have a backtrace that goes through
> __init code, even though that code no longer exists.  The symbols are
> still needed to get a decent backtrace and the overhead is minimal.

Are you sure, this is still the case? I remember, that this was the main 
reason that kernel_thread() is not an inline function anymore, so AFAICT 
there should be no relevant data on the stack anymore which points to init 
code.

bye, Roman

