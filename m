Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161126AbWJNN3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161126AbWJNN3E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 09:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030276AbWJNN3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 09:29:03 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:59297 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1422630AbWJNN3B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 09:29:01 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Date: Sat, 14 Oct 2006 15:28:48 +0200
User-Agent: KMail/1.9.5
Cc: Carsten Otte <cotte.de@gmail.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061007105758.14024.70048.sendpatchset@linux.site> <5c77e7070610120456t1bdaa95cre611080c9c953582@mail.gmail.com> <20061012120735.GA20191@wotan.suse.de>
In-Reply-To: <20061012120735.GA20191@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610141528.50542.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Thursday, 12. October 2006 14:07, Nick Piggin wrote:
> Actually, filemap_xip needs some attention I think... if xip files
> can be truncated or invalidated (I assume they can), then we need to
> lock the page, validate that it is the correct one and not truncated,
> and return with it locked.

???

Isn't XIP for "eXecuting In Place" from ROM or FLASH?
How to truncate these? I thought the whole idea of
XIP was a pure RO mapping?

They should be valid from mount to umount.

Regards

Ingo Oeser, a bit puzzled about that...
