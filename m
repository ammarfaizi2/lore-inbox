Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbUDHQ2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbUDHQ2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:28:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:13207 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262014AbUDHQ2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:28:41 -0400
Date: Thu, 8 Apr 2004 09:27:58 -0700
From: Greg KH <greg@kroah.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: s390 patches for 2.6.5.
Message-ID: <20040408162758.GB9702@kroah.com>
References: <20040408142659.GA1793@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408142659.GA1793@mschwid3.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 04:26:59PM +0200, Martin Schwidefsky wrote:
> I've included the zfcp patches in this patch set as well after I "fixed"
> the kfree problem. To get the other bug fixes into mainline I side-stepped
> the kfree issue. There are now release functions for the zfcp_unit and
> zfcp_port objects but I removed the module_exit function as well. Without
> the kfree trick we KNOW module unloading to be racy. So far we know of no
> other feasible solution for this problem. Therefore we removed the support
> for unloading of the zfcp module.

Thank you for fixing this.  I don't have a problem with this patch
anymore :)

greg k-h
