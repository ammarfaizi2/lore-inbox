Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbUKJVfJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbUKJVfJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbUKJVde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:33:34 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:55703 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261990AbUKJVcU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:32:20 -0500
Date: Wed, 10 Nov 2004 22:28:35 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: sebastian.ionita@focomunicatii.ro
Cc: seby@focomunicatii.ro, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       alan@redhat.com, jgarzik@pobox.com
Subject: Re: ZyXEL GN650-T
Message-ID: <20041110212835.GA23758@electric-eye.fr.zoreil.com>
References: <20041107214427.20301.qmail@focomunicatii.ro> <20041107224803.GA29248@electric-eye.fr.zoreil.com> <20041109000006.GA14911@electric-eye.fr.zoreil.com> <20041109232510.GA5582@electric-eye.fr.zoreil.com> <20041110201010.18341.qmail@focomunicatii.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041110201010.18341.qmail@focomunicatii.ro>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sebastian.ionita@focomunicatii.ro <sebastian.ionita@focomunicatii.ro> :
[...]
> The kernel compiles but I have 1 unresolved simbole in the via-velocity 
> modul
> depmod: *** Unresolved symbols in 
> /lib/modules/2.4.28-rc2/kernel/drivers/net/via-velocity.o
> depmod:         crc_ccitt_R3771b461 

Can you grep for crc_ccitt the output of 'nm lib/lib.a' in your build
tree and check that CONFIG_CRC_CCITT is enabled in your .config ?

crc_ccitt is EXPORT_SYMBOLed by lib/crc-ccitt.c and should be linked in
your new kernel.

--
Ueimor
