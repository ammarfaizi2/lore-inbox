Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932141AbWHGPL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbWHGPL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbWHGPL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:11:57 -0400
Received: from terminus.zytor.com ([192.83.249.54]:52710 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932133AbWHGPLz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:11:55 -0400
Message-ID: <44D7579D.1040303@zytor.com>
Date: Mon, 07 Aug 2006 08:09:17 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Daniel Rodrick <daniel.rodrick@gmail.com>
CC: Linux Newbie <linux-newbie@vger.kernel.org>,
       kernelnewbies <kernelnewbies@nl.linux.org>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Univeral Protocol Driver (using UNDI) in Linux
References: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>
In-Reply-To: <292693080608070339p6b42feacw9d8f27a147cf1771@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Rodrick wrote:
> Hi list,
> 
> I was curious as to why a Universal driver (using UNDI API) for Linux
> does not exist (or does it)?
> 
> I want to try and write a such a driver that could (in principle)
> handle all the NICs that are PXE compatible.
> 
> Has this been tried? What are the technical problems that might come in 
> my way?
> 

It has been tried; in fact Intel did implement this in their "Linux PXE 
SDK".  The UNDI API is absolutely atrocious, however, being based on 
NDIS2 which is widely considered the worst of all the many network 
stacks for DOS.

Additionally, many UNDI stacks don't work correctly when called from 
protected mode, since the interface doesn't work right.  Additionally, 
UNDI is *ONLY* available after booting from the NIC.

	-hpa
