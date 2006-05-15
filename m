Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964987AbWEORKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964987AbWEORKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 13:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964990AbWEORKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 13:10:37 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:54798 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964987AbWEORKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 13:10:36 -0400
Date: Mon, 15 May 2006 18:10:29 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc1: IDE: fix potential data corruption with SL82C105 interfaces
Message-ID: <20060515171029.GA28140@flint.arm.linux.org.uk>
Mail-Followup-To: Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20051112165548.GB28987@flint.arm.linux.org.uk> <1131818615.18258.6.camel@localhost.localdomain> <446890F0.3020408@ru.mvista.com> <1147706716.26686.64.camel@localhost.localdomain> <4468A6E2.5060305@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4468A6E2.5060305@ru.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 08:05:54PM +0400, Sergei Shtylyov wrote:
> >The caching is one bug, the
> >fact the reset hits both channels is the other I know about.
> 
>    Ah, that register 0x7E reset? Strangely, W83C55[34]F datasheets don't 
>    even mention it. :-/

They don't - it's an undocumented register as far as the data sheets go,
but if you're lucky enough to have the chip errata, you'll be told to
use it explicitly to work around bugs.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
