Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbULIOx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbULIOx3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261519AbULIOx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:53:28 -0500
Received: from yacht.ocn.ne.jp ([222.146.40.168]:45549 "EHLO
	smtp.yacht.ocn.ne.jp") by vger.kernel.org with ESMTP
	id S261482AbULIOxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:53:15 -0500
From: Akinobu Mita <amgta@yacht.ocn.ne.jp>
To: Greg Banks <gnb@sgi.com>, John Levon <levon@movementarian.org>
Subject: Re: [mm patch] oprofile: backtrace operation does not initialized
Date: Thu, 9 Dec 2004 23:53:53 +0900
User-Agent: KMail/1.5.4
Cc: Greg Banks <gnb@sgi.com>, Philippe Elie <phil.el@wanadoo.fr>,
       linux-kernel@vger.kernel.org
References: <200412081830.51607.amgta@yacht.ocn.ne.jp> <20041209015024.GG4239@sgi.com> <200412092322.27096.amgta@yacht.ocn.ne.jp>
In-Reply-To: <200412092322.27096.amgta@yacht.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412092353.53634.amgta@yacht.ocn.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 09 December 2004 23:22, Akinobu Mita wrote:

> Since the timer interrupt is the only way of getting sampling for oprofile
> on such environments. if no module parameters specified (i.e. timer == 0),
> then oprofile_timer_init() is never called. and I have got this error:

My first patch is not so bad, I think.

Or, It may be better to revert the return type of oprofile_arch_init()
from "void" to "int"  to get the result of initialization.
Though I don't know when/why its interface was changed. and some
architectures (ppc, sh64, m32r) remain to have old interfaces in -mm.



