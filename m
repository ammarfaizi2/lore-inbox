Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVADSMC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVADSMC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 13:12:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261749AbVADSMC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 13:12:02 -0500
Received: from mail.convergence.de ([212.227.36.84]:50893 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S261745AbVADSMA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 13:12:00 -0500
Date: Tue, 4 Jan 2005 19:11:53 +0100
From: Johannes Stezenbach <js@linuxtv.org>
To: Arne Ahrend <aahrend@web.de>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [linux-dvb-maintainer] PATCH: DVB bt8xx in 2.6.10
Message-ID: <20050104181153.GA1416@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Arne Ahrend <aahrend@web.de>, linux-dvb-maintainer@linuxtv.org,
	linux-kernel@vger.kernel.org
References: <20050104175043.6a8fd195.aahrend@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050104175043.6a8fd195.aahrend@web.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arne Ahrend wrote:
> This patch allows the user to select only actually desired frontend driver(s) for
> bt8xx based DVB cards by removing calls to frontend-specific XXX_attach()
> functions and returning NULL instead for unconfigured frontends.
> 
> To keep this patch small, no attempt is made to #ifdef away other static functions or data
> for unselected frontends. This leads to compiler warnings about defined, but unused
> code, unless all four frontends relevant to bt8xx based cards are selected.
> 
> I have tested this on the Avermedia 771 (the only DVB card I have access to).

This approach has been discussed on the linux-dvb list and was rejected
because of the huge #ifdef mess it creates (you just touched bt8xx, it's
even worse for saa7146 based cards). The frontend drivers are
tiny so I think you can afford to load some that aren't actually
used by your hardware.

Johannes
