Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261242AbSJQJbD>; Thu, 17 Oct 2002 05:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261264AbSJQJbD>; Thu, 17 Oct 2002 05:31:03 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35708 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261242AbSJQJbC>; Thu, 17 Oct 2002 05:31:02 -0400
To: James Finnie <jf1@IMERGE.co.uk>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'andre@linux-ide.org'" <andre@linux-ide.org>
Subject: Re: [PATCH]:  Sanity checking for drives that claim to be LBA-48, but aren't!
References: <C0D45ABB3F45D5118BBC00508BC292DB9D4264@imgserv04>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Oct 2002 03:35:12 -0600
In-Reply-To: <C0D45ABB3F45D5118BBC00508BC292DB9D4264@imgserv04>
Message-ID: <m1vg411k8f.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Finnie <jf1@IMERGE.co.uk> writes:

> The kernel sees this bit set, tries to use LBA-48 commands, and the drive
> errors, complaining that it doesn't understand!  Meaning this drive is
> unusable with the >=2.4.19 kernels.  I think at least one other person has
> reported something very similar, IIRC with a very old Maxtor IDE drive.
> 
> Here is a patch that does some basic sanity checking.  If the drive has an
> lba_capacity_2==0, and has the bit set claiming to be LBA-48, it ignores
> this claim.
> 
There are also a set of bits that reports which revs of the ATA standard
a drive complies with.  Should we check that one as well?  

Eric
 
