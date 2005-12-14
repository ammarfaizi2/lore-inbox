Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVLNREB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVLNREB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 12:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932465AbVLNREB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 12:04:01 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:33956 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932400AbVLNREA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 12:04:00 -0500
From: David Brownell <david-b@pacbell.net>
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH/RFC] SPI: add DMAUNSAFE analog to David Brownell's core
Date: Wed, 14 Dec 2005 08:55:43 -0800
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, dpervushin@gmail.com, akpm@osdl.org,
       greg@kroah.com, basicmark@yahoo.com, komal_shah802003@yahoo.com,
       stephen@streetfiresound.com, spi-devel-general@lists.sourceforge.net,
       Joachim_Jaeger@digi.com
References: <20051212182026.4e393d5a.vwool@ru.mvista.com> <200512131101.02025.david-b@pacbell.net> <439F47F1.1060909@ru.mvista.com>
In-Reply-To: <439F47F1.1060909@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512140855.43976.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 December 2005 2:15 pm, Vitaly Wool wrote:

> Take for instance spi_w8r8 function used in lotsa places in the drivers 
> you and Stephen have posted.
> This function has a) *implicit memcpy* inherited from 
> spi_write_then_read b) *implicit priority inversion* inherited from the 
> same place.

No, (a) is explicit, along with comments not to use that family of
calls when such things matter more than the convenience of those
RPC-ish calls.  And (b) was fixed a small patch, now merged.

- Dave

