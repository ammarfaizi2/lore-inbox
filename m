Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267777AbUHEQje@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267777AbUHEQje (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:39:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267783AbUHEQjc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:39:32 -0400
Received: from the-village.bc.nu ([81.2.110.252]:53693 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267777AbUHEQjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:39:21 -0400
Subject: Re: /dev/hdl not showing up because of
	fix-ide-probe-double-detection patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: Tupshin Harper1 <tupshin@tupshin.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040804224709.3c9be248.akpm@osdl.org>
References: <411013F7.7080800@tupshin.com> <4111651E.1040406@tupshin.com>
	 <20040804224709.3c9be248.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091720165.8041.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 05 Aug 2004 16:36:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-08-05 at 06:47, Andrew Morton wrote:
> > Well, I found the source of the problem. Dmesg gives a "ignoring 
> > undecoded slave" message, which is coming from the 
> > fix-ide-probe-double-detection patch.
> 
> Ah, thanks for working that out.
> 
> Did you know that Cc: stands for "copy culprit"?
> 
> > Both /dev/hdk and /dev/hdl are the same model of hard drive, and 
> > unfortunately, they both report that they are Model 
> > M0000000000000000000, which triggers the double detection removal.

I need the real model and serial number information not "MOOO" to debug
this kind of thing
 
> > Also, what is in /proc/ide/hd?/identity besides serial number. The two 
> > drives have very similar identity files, but they are slightly 
> > different. Could that additional info be used to check for duplicates?

Two disks are not permitted to have the same serial number. If you can
give me the full ident data I'll take a detailed look - could be I'm not
comparing enough bytes if its only different on the last digit.

Alan

