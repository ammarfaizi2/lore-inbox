Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269239AbUJFMU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269239AbUJFMU0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 08:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269240AbUJFMU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 08:20:26 -0400
Received: from chaos.analogic.com ([204.178.40.224]:2944 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S269239AbUJFMUR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 08:20:17 -0400
Date: Wed, 6 Oct 2004 08:20:16 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
To: linux-kernel@vger.kernel.org
Subject: 'C' calling convention change.
Message-ID: <Pine.LNX.4.61.0410060816430.3420@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The new Red Hat Fedora release uses the following gcc version:

 	gcc (GCC) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)

I have many assembly-language routines that need to interface with
'C' code. The new 'C' compiler is doing something different than
gcc 3.2, previously used.

I need to know what general-purpose registers need to be saved
in the called procedure. Previously, one needed to save the
index registers only (%ebx, %edi, %esi). Apparently I need to
save others with the new compiler because, although the called
procedures work, subsequent 'C' code fails in strange ways.

Please, if somebody __knows__ (really knows), let me know. I
will have to edit over 200 assembly-language files and I want
to do it only once!  I don't want to just save all the registers
used because this wastes CPU cycles and the only reason for
the assembly in the first place was to save CPU cycles.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.5-1.358-noreg on an i686 machine (5570.56 BogoMips).
             Note 96.31% of all statistics are fiction.

