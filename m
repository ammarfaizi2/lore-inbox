Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262322AbVBQUUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262322AbVBQUUI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 15:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVBQUUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 15:20:08 -0500
Received: from one.firstfloor.org ([213.235.205.2]:37261 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262322AbVBQUTu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 15:19:50 -0500
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86_64: AGP support for SiS760?
References: <42148EAA.10001@winischhofer.net>
From: Andi Kleen <ak@muc.de>
Date: Thu, 17 Feb 2005 21:19:45 +0100
In-Reply-To: <42148EAA.10001@winischhofer.net> (Thomas Winischhofer's
 message of "Thu, 17 Feb 2005 13:31:38 +0100")
Message-ID: <m18y5nc526.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Winischhofer <thomas@winischhofer.net> writes:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
>
> The SiS760 is an AMD64 chipset and AGP support works nicely in 32bit
> mode. So why is AGP_SIS only configurable if !X86_64?

Normally all AMD64 systems use only the AMD64 driver. That's because
most of the AGP setup (the aperture) is in the CPU, not on the chipset
and can be handled by a shared driver. SIS should work this way too. 

-Andi
