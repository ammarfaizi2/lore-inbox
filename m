Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264730AbTAJJbF>; Fri, 10 Jan 2003 04:31:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264739AbTAJJbE>; Fri, 10 Jan 2003 04:31:04 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:52626 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264730AbTAJJbD>; Fri, 10 Jan 2003 04:31:03 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Prevent .gnu.linkonce.this_module section from being merged with other sections
References: <20030110091012.0E15E2C2AF@lists.samba.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 10 Jan 2003 18:39:39 +0900
In-Reply-To: <20030110091012.0E15E2C2AF@lists.samba.org>
Message-ID: <buo1y3l9wdg.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:
> > +++ linux-2.5.55-moo/Makefile	2003-01-09 14:07:36.000000000 +0900
> > -LDFLAGS_MODULE  = -r
> > +LDFLAGS_MODULE  = -r --unique=.gnu.linkonce.this_module
> 
> No!  Does this not work?
> 
> +++ working-2.5.55-strlen/arch/v850/Makefile	2003-01-10 19:32:09.000000000 +1100
> +LDFLAGS_MODULE += --unique=.gnu.linkonce.this_module

That'll probably work too.

[Though since the module loader depends on .gnu.linkonce.this_module
being a unique section, I think the global option should be OK as well]

-Miles
-- 
Is it true that nothing can be known?  If so how do we know this?  -Woody Allen
