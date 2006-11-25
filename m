Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966435AbWKYLhd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966435AbWKYLhd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 06:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966437AbWKYLhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 06:37:33 -0500
Received: from outmail1.freedom2surf.net ([194.106.33.237]:9879 "EHLO
	outmail.freedom2surf.net") by vger.kernel.org with ESMTP
	id S966435AbWKYLhd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 06:37:33 -0500
Message-ID: <45682B0E.4060202@f2s.com>
Date: Sat, 25 Nov 2006 11:37:50 +0000
From: Ian Molton <spyro@f2s.com>
Organization: The Dragon Roost
User-Agent: Thunderbird 2.0a1 (X11/20061107)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [Kernel-discuss] RFC - platform device, IRQs and SoC devices
References: <4563242D.9050901@f2s.com>
In-Reply-To: <4563242D.9050901@f2s.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Molton wrote:
> Hi there.
> 
> Im working on some SoC type devices attached to the system bus of my ARM 
> devboard in an isa-like way.
> 
> The devices are small SoC (System On Chip) types, with one IRQ routed to 
> the half dozen (sub)devices on board the SoC.

I just thought of a 'third way'.

let IRQchips have their own struct irq_desc and have subdevice IRQs 
start from 0.

since those IRQs can only be raised by the parent chip I think this 
ought to work, and would eliminated the problem of a fixed size irq array...
