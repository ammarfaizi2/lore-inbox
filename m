Return-Path: <linux-kernel-owner+w=401wt.eu-S1161050AbWLUAGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161050AbWLUAGV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 19:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWLUAGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 19:06:20 -0500
Received: from austin.greshamstorage.com ([216.143.252.250]:2555 "EHLO
	austin.greshamstorage.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161050AbWLUAGU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 19:06:20 -0500
X-Greylist: delayed 924 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 19:06:19 EST
Message-ID: <4589CC5B.9090704@greshamstorage.com>
Date: Wed, 20 Dec 2006 17:50:51 -0600
From: Jeremy Linton <jli@greshamstorage.com>
Organization: Gresham Enterprise Storage
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: Dan Aloni <da-x@monatomic.org>
CC: Arjan van de Ven <arjan@fenrus.demon.nl>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-scsi@vger.kernel.org, Mike Christie <michaelc@cs.wisc.edu>
Subject: Re: [PATCH] scsi_execute_async() should add to the tail of the queue
References: <20061219083507.GA20847@localdomain> <1166522613.3365.1198.camel@laptopd505.fenrus.org> <4587C04E.10307@monatomic.org>
In-Reply-To: <4587C04E.10307@monatomic.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So instead of adding a parameter, we can make scsi_execute_async()
> decide for itself based on the SCSI command, with read/write I/Os
> taking the lowest priority.
	This seems like a bad idea, I can come up with a number of cases where 
the priority of a request would better be optimized by a higher level 
subsystem, rather than a simple prioritization based on the command type.

The original suggestion to provide both head and tail insertion options 
seems like the obvious solution, short of a full priority queuing system.




