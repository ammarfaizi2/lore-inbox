Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752104AbWCEXlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104AbWCEXlE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:41:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752277AbWCEXlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:41:04 -0500
Received: from mail.dvmed.net ([216.237.124.58]:39131 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752104AbWCEXlB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:41:01 -0500
Message-ID: <440B770A.8090707@garzik.org>
Date: Sun, 05 Mar 2006 18:40:58 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PATA failure with piix, works with libata
References: <20060303183937.GA30840@srcf.ucam.org> <20060305225733.GA8578@srcf.ucam.org>
In-Reply-To: <20060305225733.GA8578@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> Ok, it /seems/ that things are happier (though still not entirely happy) 
> if I explicitly acknowledge the interrupt by writing the dma status 
> register back again. This doesn't seem to be done anywhere in the IDE 
> interrupt routine, but is in the libata one. I'm afraid I don't 
> understand IDE well enough to have any idea what's going on here - is it 
> possible that a piix in native mode (rather than legacy mode) and 
> sharing an interrupt needs some special handling?

ICH definitely needs that irq ack...

	Jeff



