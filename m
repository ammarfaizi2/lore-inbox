Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161281AbWHDQQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161281AbWHDQQd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 12:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161282AbWHDQQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 12:16:33 -0400
Received: from ns2.suse.de ([195.135.220.15]:54676 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161281AbWHDQQc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 12:16:32 -0400
From: Andreas Schwab <schwab@suse.de>
To: Jes Sorensen <jes@sgi.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>,
       ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] A generic boolean
References: <1153341500.44be983ca1407@portal.student.luth.se>
	<44BE9E78.3010409@garzik.org> <yq0lkq4vbs3.fsf@jaguar.mkp.net>
	<1154702572.23655.226.camel@localhost.localdomain>
	<44D35B25.9090004@sgi.com>
	<1154706687.23655.234.camel@localhost.localdomain>
	<44D36E8B.4040705@sgi.com> <je4pws1ofb.fsf@sykes.suse.de>
	<44D370ED.2050605@sgi.com>
X-Yow: RELAX!! ... This is gonna be a HEALING EXPERIENCE!!  Besides,
 I work for DING DONGS!
Date: Fri, 04 Aug 2006 18:16:30 +0200
In-Reply-To: <44D370ED.2050605@sgi.com> (Jes Sorensen's message of "Fri, 04
	Aug 2006 18:08:13 +0200")
Message-ID: <jezmekzdb5.fsf@sykes.suse.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@sgi.com> writes:

> We know that today long is the only one that differs and that
> m68k has horrible natural alignment rules for historical reasons, but
> besides that it's pretty sane.

Try determining the alignment of u64 on i386.  You will be surprised.

#include <stdio.h>

typedef long long u64;
struct u64_s { u64 x; } x;

int main ()
{
  printf ("%d\n", __alignof__ (u64));
  printf ("%d\n", __alignof__ (x));
  return 0;
}

Btw, the iptables compat code was broken due to this.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
