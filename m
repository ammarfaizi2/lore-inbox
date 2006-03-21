Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWCUJdW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWCUJdW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 04:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbWCUJdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 04:33:22 -0500
Received: from webapps.arcom.com ([194.200.159.168]:24844 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S932360AbWCUJdW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 04:33:22 -0500
Message-ID: <441FC856.90602@arcom.com>
Date: Tue, 21 Mar 2006 09:33:10 +0000
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>
CC: Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/23] driver core: platform_get_irq*(): return -ENXIO
 on error
References: <11428920373568-git-send-email-gregkh@suse.de> <11428920383013-git-send-email-gregkh@suse.de> <20060321001336.GB84147@dspnet.fr.eu.org>
In-Reply-To: <20060321001336.GB84147@dspnet.fr.eu.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2006 09:33:14.0910 (UTC) FILETIME=[7A8243E0:01C64CCA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert wrote:
> On Mon, Mar 20, 2006 at 02:00:38PM -0800, Greg Kroah-Hartman wrote:
> 
>>platform_get_irq*() cannot return 0 on error as 0 is a valid IRQ on some
>>platforms, return -ENXIO instead.
> 
> 
> 0 is NO_IRQ, and can not be a valid IRQ number, ever.  A
> platform_get_irq*() returning 0 as a valid irq is buggy.
> 
> Check http://lkml.org/lkml/2005/11/21/211

Regardless, it does make sense to make these functions to return a -ve
error code as is standard.

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
