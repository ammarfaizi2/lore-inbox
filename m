Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751423AbVIINiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751423AbVIINiJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 09:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbVIINiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 09:38:09 -0400
Received: from relay7.mail.ox.ac.uk ([129.67.1.167]:10928 "EHLO
	relay7.mail.ox.ac.uk") by vger.kernel.org with ESMTP
	id S1751423AbVIINiH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 09:38:07 -0400
Date: Fri, 9 Sep 2005 14:38:04 +0100
From: Ian Collier <Ian.Collier@comlab.ox.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.13: loop ioctl crashes
Message-ID: <20050909143804.A23692@pixie.comlab>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050909132725.C23462@pixie.comlab> <Pine.LNX.4.61.0509090829260.8368@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0509090829260.8368@chaos.analogic.com>; from linux-os@analogic.com on Fri, Sep 09, 2005 at 08:32:10AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 09, 2005 at 08:32:10AM -0400, linux-os (Dick Johnson) wrote:
> I guess you are trying to do a copy_from_user() with a spin-lock
> being held or the interrupts otherwise disabled. You can hold
> a semaphore, to prevent somebody else from interfering with
> you, but you cannot hold a spin-lock during copy/to/from/user().

Well, I didn't write the code (it's right there in drivers/block/loop.c
in 2.6.13) and I can't see where there's a spin-lock.  In fact it does
use a semaphore.

imc
