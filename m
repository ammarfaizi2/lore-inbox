Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312491AbSDCXuB>; Wed, 3 Apr 2002 18:50:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312494AbSDCXtv>; Wed, 3 Apr 2002 18:49:51 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9740 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312491AbSDCXth>;
	Wed, 3 Apr 2002 18:49:37 -0500
Message-ID: <3CAB9518.5090409@mandrakesoft.com>
Date: Wed, 03 Apr 2002 18:49:44 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Denny Gudea <ekay@ecs.fullerton.edu>
CC: andrewm@uow.edu.au, netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 3c59x.c - kernel message explosion (fwd)
In-Reply-To: <Pine.GSO.4.33.0204031538340.19587-100000@titan.ecs.fullerton.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denny Gudea wrote:
> i believe the problem resides when it tests for the debug level:
> 
> 	          if (vortex_debug > 2
>                         || (tx_status != 0x88 && vortex_debug > 0)) {
> 
> the || operator should be a && because we only want to print the error
> message if debug is greater than 2 and the transmit status is not what it
> should be.



the test looks ok...  it prints if the status is not what it should be, 
if vortex_debug is 1 or 2, and unconditionally prints the status if 
vortex_debug is 3 or greater.

What is your vortex_debug setting?

	Jeff




