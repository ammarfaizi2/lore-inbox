Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262769AbUJ0XHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262769AbUJ0XHj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 19:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUJ0W5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 18:57:54 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:30880 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262748AbUJ0WyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 18:54:08 -0400
Subject: Re: [PATCH] Add p4-clockmod driver in x86-64
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@tux.tmfweb.nl
Cc: Paulo Marques <pmarques@grupopie.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Andi Kleen <ak@suse.de>, akpm@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041027213807.GA9334@nospam.com>
References: <88056F38E9E48644A0F562A38C64FB600333A69D@scsmsx403.amr.corp.intel.com>
	 <417FB7BA.9050005@grupopie.com>  <20041027213807.GA9334@nospam.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1098913837.7783.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 27 Oct 2004 22:50:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-10-27 at 22:38, Rutger Nijlunsing wrote:
> So you've got the _disadvantages_ of a slow clock (programs run
> slower), and not the _advantages_ (power consumption is same as idle
> CPU and not lower, temperature is same as idle CPU and not lower).
> 
> But why does the P4 have such a mode? It uses this mode during thermal
> throttling to get to the 'idle' temperature.

It isn't obvious how you software idle a PIV - "hlt" at least does not
seem to do that.

> Therefore, p4-clockmod is completely misnamed: it's _not_ a cpufreq
> driver in the sense that it does not change the frequency.

It performs a similar function less efficiently. Lots of older chipsets
for K6 and the like also only support this form of clock control.

Alan

