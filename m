Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267472AbUHRSpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267472AbUHRSpI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 14:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267476AbUHRSpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 14:45:08 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:24979 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S267472AbUHRSpE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 14:45:04 -0400
From: David Brownell <david-b@pacbell.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [patch] enums to clear suspend-state confusion
Date: Wed, 18 Aug 2004 11:28:00 -0700
User-Agent: KMail/1.6.2
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mochel@digitalimplant.org, benh@kernel.crashing.org
References: <20040812120220.GA30816@elf.ucw.cz> <20040818002711.GD15046@elf.ucw.cz> <1092850283.26049.20.camel@localhost.localdomain>
In-Reply-To: <1092850283.26049.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408181128.00217.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 August 2004 10:31 am, Alan Cox wrote:
>    It would also be nice
> to have a driver flag to indicate which devices can simply be
> hotunplug/hotreplugged over a suspend and don't need extra duplicate
> code.

In fact, that should be the default:  if there's no suspend(),
use drivers' unplug/replug logic.  Bugs in that code need to be
fixed regardless of PM being used (or not).

Right now that won't work because of a self-deadlock
in the PM core, but that's a fixable problem.

