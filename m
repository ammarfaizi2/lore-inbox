Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWDUPp7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWDUPp7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751190AbWDUPp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:45:59 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:37574 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751188AbWDUPp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:45:59 -0400
Subject: Re: [PATCH/RFC] s390: Hypervisor File System
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, mschwid2@de.ibm.com, penberg@gmail.com
In-Reply-To: <OF5500FC25.13788C4B-ON42257157.004C98F0-42257157.004DB206@de.ibm.com>
References: <OF5500FC25.13788C4B-ON42257157.004C98F0-42257157.004DB206@de.ibm.com>
Date: Fri, 21 Apr 2006 18:38:18 +0300
Message-Id: <1145633898.13191.9.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

On Fri, 2006-04-21 at 16:08 +0200, Michael Holzheu wrote:
> The first one was, that the hardware interface for getting the data is
> very expensive. We always get back the data for all LPARs and all
> cpus. Therefore we do not want to get the data every time an attribute
> file is read.

You can cache the results in userspace. So I don't see this one as an
argument for making the kernel more complex.

On Fri, 2006-04-21 at 16:08 +0200, Michael Holzheu wrote:
> The second problem was, that we want to provide a consistent snapshot
> of the hypervisor data for the user space application.

How do you ensure consistency now? And how is that different from an
userspace process reading the whole directory hierarchy into cache in
one go?

The update-on-write to special file thing seems bit strange to me. What
if two processes ask for it at the same time?

				Pekka

