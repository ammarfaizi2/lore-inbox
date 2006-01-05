Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWAESD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWAESD7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWAESD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:03:59 -0500
Received: from cantor2.suse.de ([195.135.220.15]:17868 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932116AbWAESD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:03:58 -0500
From: Andi Kleen <ak@suse.de>
To: dtor_core@ameritech.net
Subject: Re: 2.6.15-ck1
Date: Thu, 5 Jan 2006 18:28:46 +0100
User-Agent: KMail/1.8.2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       ck list <ck@vds.kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200601041200.03593.kernel@kolivas.org> <200601051739.05441.ak@suse.de> <d120d5000601050913n54677e8bib01f4bd70d5f7ee4@mail.gmail.com>
In-Reply-To: <d120d5000601050913n54677e8bib01f4bd70d5f7ee4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601051828.47133.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 January 2006 18:13, Dmitry Torokhov wrote:

> Yes, until some driver claims serio port interrupt is not acquired and
> thus available for others.
> 
> I would say we could bump the timer as high as 5 seconds for
> hotplugging. It may give delay with some KVMs, but only first time you
> switch to the box in question.

I would say you just should aquire the interrupt always. Running
a timer instead of just using the perfectly fine interrupt looks simply like 
a design bug, not a feature.

-Andi
