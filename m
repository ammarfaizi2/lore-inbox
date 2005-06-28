Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVF1LsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVF1LsO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVF1LsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:48:14 -0400
Received: from [212.76.81.153] ([212.76.81.153]:35588 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S261368AbVF1LsM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:48:12 -0400
Message-Id: <200506281147.OAA20216@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Nix'" <nix@esperi.org.uk>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: RE: Kswapd flaw
Date: Tue, 28 Jun 2005 14:47:15 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <87r7em69h2.fsf@amaterasu.srvr.nix>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Thread-Index: AcV7ztGawRTh4Lx0RtCA5gc1h+AxvQAAk0JA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2005, Al Boldi murmured woefully:
> Kswapd starts evicting processes to fullfil a malloc, when it should 
> just deny it because there is no swap.
Nix wrote:
> I can't even tell what you're expecting. Surely not that no pages are ever
evicted or flushed;
> your memory would fill up with page cache in no time.

Nix,
Please do flush anytime, and do it in sync during OOMs; but don't evict
procs especially not RUNNING procs, that is overkill.


