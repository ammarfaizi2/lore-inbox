Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136772AbREKOhH>; Fri, 11 May 2001 10:37:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135801AbREKOg5>; Fri, 11 May 2001 10:36:57 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:64777 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131949AbREKOgi>; Fri, 11 May 2001 10:36:38 -0400
Subject: Re: LVM 1.0 release decision
To: Mauelshagen@sistina.com
Date: Fri, 11 May 2001 15:32:46 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, mge@sistina.com
In-Reply-To: <20010511162745.B18341@sistina.com> from "Heinz J. Mauelshagen" at May 11, 2001 04:27:45 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14yDyI-0000yE-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This leads to the dilemma, that trying to avoid further differences between
> our LVM releases and the stock kernel code would force us into postponing
> the pending LVM 1.0 release accordingly which OTOH is incovenient for the LVM
> user base.
> 
> In regard to this situation we'ld like to know about your oppinion on
> the following request:
> is it acceptable to release 1.0 soon *before* all patches to reach the 1.0 code

Please fix the binary incompatibility in the on disk format between the current
code and your new release _before_ you do that. The last patches I was sent
would have screwed every 64bit LVM user.

A new format is fine but import old ones properly. And if you do a new format
stop using kdev_t on disk - it will change size soon

Alan

