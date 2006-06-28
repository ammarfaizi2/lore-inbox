Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbWF1SAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbWF1SAX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 14:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750700AbWF1SAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 14:00:22 -0400
Received: from gw.goop.org ([64.81.55.164]:29060 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1750702AbWF1SAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 14:00:21 -0400
Message-ID: <44A2C3B7.3040400@goop.org>
Date: Wed, 28 Jun 2006 11:00:23 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Greg KH <gregkh@suse.de>, Rafa? Bilski <rafalbilski@interia.pl>,
       linux-kernel@vger.kernel.org, davej@redhat.com
Subject: Re: [PATCH] (Longhaul 1/5) PCI: Protect bus master DMA from	Longhaul
 by rw semaphores
References: <44A28AA2.6060306@interia.pl>  <20060628173448.GA2371@suse.de> <1151517780.15166.52.camel@localhost.localdomain>
In-Reply-To: <1151517780.15166.52.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> I am still not clear if this is just cache corruption through us not
> listening or whether we genuinely need to halt.
Especially buggy steppings of C3s would stop snooping while in 'hlt', so 
it wouldn't surprise me if they stopped while doing a speed transition.

>  In the former case
> flushing and disabling the CPU caches ought to be sufficient.
>   
Sounds reasonable, unless that causes problems of its own.  (My general 
experience with Via CPUs is that doing anything even slightly unusual 
will result in strange behaviour or outright buggyness.)

    J
