Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932338AbWCGVHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbWCGVHB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 16:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWCGVHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 16:07:01 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:45226 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751607AbWCGVHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 16:07:00 -0500
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
Subject: Re: PROBLEM: four bttv tuners in one PC crashed
Date: Tue, 7 Mar 2006 20:43:43 +0100
User-Agent: KMail/1.9.1
Cc: Linux and Kernel Video <video4linux-list@redhat.com>,
       linux-kernel@vger.kernel.org
References: <440C5672.7000009@cern.ch> <440D7384.5030307@cern.ch> <440DDA46.2010503@hispeed.ch>
In-Reply-To: <440DDA46.2010503@hispeed.ch>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603072043.44210.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The bttv driver/chip seems to cause random memory corruption sometimes, 
> processes will just start dying...

There is a known buffer overflow in the bttv driver (when using
grabdisplay).  The fix is waiting on an audit of the rest of the
bttv (and similar) code, since it looks like the same mistake
occurs in several places.

Ciao,

D.
