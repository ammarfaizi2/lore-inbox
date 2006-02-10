Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWBJXVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWBJXVe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWBJXVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:21:34 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:27293 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750885AbWBJXVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:21:33 -0500
Subject: Re: CD-blanking leads to machine freeze with current -git [was:
	Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux
	(stirring up a hornets' nest) ]]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Koschewski <marc@osknowledge.org>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060210210006.GA5585@stiffy.osknowledge.org>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
	 <20060210175848.GA5533@stiffy.osknowledge.org>
	 <43ECE734.5010907@cfl.rr.com>
	 <20060210210006.GA5585@stiffy.osknowledge.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Feb 2006 23:23:54 +0000
Message-Id: <1139613834.14383.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2006-02-10 at 22:00 +0100, Marc Koschewski wrote:
> than to run this as root. Couldn't cdrecord 'watch' ide load or - even better -
> forcecast it? It knows blanking leads to inresponsiveness sometimes (even more due
> to the fact that both devices share the same bus). Why not kind of  'renice'
> the process that blanks?

It isn't about load. You issue a command to an ATA device and there is
no disconnect sequence as SCSI has. That bus is now locked until the
command completes.

There are mechanisms for certain cases like blanking and fixating that
allow you to avoid this. Some cd record apps let you choose them.  There
isn't anything the kernel can do however.

Alan

