Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVC3AYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVC3AYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 19:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVC3AYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 19:24:45 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:15585 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261671AbVC3AYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 19:24:31 -0500
Message-ID: <4249F1B0.6050800@nortel.com>
Date: Tue, 29 Mar 2005 18:24:16 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peterc@gelato.unsw.edu.au>
CC: krishna <krishna.c@globaledgesoft.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: How to measure time accurately.
References: <424779F3.5000306@globaledgesoft.com>	<4248E282.1000105@nortel.com> <16969.58762.180127.283274@wombat.chubb.wattle.id.au>
In-Reply-To: <16969.58762.180127.283274@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:
>>>>>>"Chris" == Chris Friesen <cfriesen@nortel.com> writes:

> Chris> Most cpus have some way of getting at a counter or decrementer
> Chris> of various frequencies.  Usually it requires low-level hardware
> Chris> knowledge and often it needs assembly code.
> 
> As a device driver is inside the linux kernel (unless you're writein a
> user-mode device driver :-)) you can use the getcycles() macro that's
> defined for most architectures.  It provides a snapshot of the
> cycle-counter.

For ppc this only gives 32-bit values, which overflow every 129 seconds 
on my G5.  Depending on how long you're trying to time, this could be a 
problem.

Chris
