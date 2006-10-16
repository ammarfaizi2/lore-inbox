Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030346AbWJPKPl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030346AbWJPKPl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 06:15:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWJPKPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 06:15:23 -0400
Received: from cantor2.suse.de ([195.135.220.15]:29119 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030347AbWJPKPU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 06:15:20 -0400
From: Andi Kleen <ak@suse.de>
To: eranian@hpl.hp.com
Subject: Re: [PATCH] x86_64 add missing enter_idle() calls
Date: Mon, 16 Oct 2006 12:08:13 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20061006081607.GB8793@frankl.hpl.hp.com>
In-Reply-To: <20061006081607.GB8793@frankl.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610161208.13628.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 10:16, Stephane Eranian wrote:
> Hi,
> 
> Unless I am mistaken, I think we are missing some calls to enter_idle()
> in the x86_64 tree. The following patch adds a bunch of missing
> enter_idle() callbacks for some of the "direct" interrupt handlers.
> 
> changelog:
> 	- adds missing enter_idle() calls to most of the "direct" interrupt
> 	  handlers.

HLT returns after an interrupt and then does enter_idle()

At least that's the theory. Do you have any evidence it doesn't work?

-Andi
