Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWH3JBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWH3JBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 05:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750736AbWH3JBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 05:01:21 -0400
Received: from aun.it.uu.se ([130.238.12.36]:21682 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S1750735AbWH3JBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 05:01:20 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17653.21437.207484.526897@alkaid.it.uu.se>
Date: Wed, 30 Aug 2006 11:00:45 +0200
From: Mikael Pettersson <mikpe@it.uu.se>
To: Paul Mackerras <paulus@samba.org>
Cc: Olaf Hering <olaf@aepfle.de>, Nathan Lynch <ntl@pobox.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc-dev@ozlabs.org
Subject: Re: Linux v2.6.18-rc5
In-Reply-To: <17653.11388.637189.113422@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0608272122250.27779@g5.osdl.org>
	<20060829115537.GA24256@aepfle.de>
	<20060829130629.GW11309@localdomain>
	<20060829155216.GA25861@aepfle.de>
	<17653.11388.637189.113422@cargo.ozlabs.ibm.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras writes:
 > Olaf,
 > 
 > This patch should fix it.  The problem was that I was comparing a
 > 32-bit quantity with a 64-bit quantity, and consequently time wasn't
 > advancing.  This makes us use a 64-bit quantity on all platforms,
 > which ends up simplifying the code since we can now get rid of the
 > tb_last_stamp variable (which actually fixes another bug that Ben H
 > and I noticed while going carefully through the code).
 > 
 > This works fine on my G4 tibook.  Let me know how it goes on your
 > machines.

Thanks. This fixed a kernel hang bug on my G4 eMac with 2.6.18-rc5.

The vanilla kernel ran fine until I tar xvf'd a file from an NFS-mount,
then everything ground to a halt.

/Mikael
