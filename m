Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262819AbVCWG0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262819AbVCWG0e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 01:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbVCWG0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 01:26:33 -0500
Received: from fire.osdl.org ([65.172.181.4]:9608 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262819AbVCWG01 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 01:26:27 -0500
Date: Tue, 22 Mar 2005 22:26:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Markus Dahms <dahms@fh-brandenburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Lockup using ALi SATA controller (sata_uli)
Message-Id: <20050322222606.760e03e4.akpm@osdl.org>
In-Reply-To: <20050321224410.GA27760@fh-brandenburg.de>
References: <20050321224410.GA27760@fh-brandenburg.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Markus Dahms <dahms@fh-brandenburg.de> wrote:
>
>  I have a reproducable lockup of my system using an ALi SATA controller
>  and writing some 100 MB to the attached disk.
> 
> ...
>  Do you have some hints?

As a test you might like to try an uniprocessor kernel - we do have a
deadlock on the sata error recovery paths at present.

Or ensure that you've enabled the io-apci in Kconfig and boot with
nmi_watchdog=1.

