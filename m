Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTGKPNx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jul 2003 11:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTGKPNx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jul 2003 11:13:53 -0400
Received: from smtp.mailbox.net.uk ([195.82.125.32]:13774 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S263281AbTGKPNw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jul 2003 11:13:52 -0400
Date: Fri, 11 Jul 2003 16:19:55 +0100 (BST)
From: Jon Masters <jonathan@jonmasters.org>
To: linux-kernel@vger.kernel.org
cc: jcm@printk.net
Subject: Stripped binary insertion with the GNU Linker suggestions (fwd)
Message-ID: <Pine.LNX.4.10.10307111619290.25244-100000@router>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a linker script which amongst other things contains:

MEMORY
{
  sdram_linux    : ORIGIN = 0x00500000, LENGTH = 4M
}

SECTIONS {

.linux    :
{ linux_kernel } > sdram_linux

}

What I have is a stripped kernel image which I want to shove in to a
section in the output elf file though the Linker complains it does not
recognise the file format (as it perhaps should). I realise that the
above is not the correct way to do this - suggestions are very welcome.

I have seen other nasty ways to do this involving converting the image to
byte values in very large arrays or inserting literal byte values in to
the output file but there just has to be a generic method for inserting
an image in to the middle of an output file.

Cheers,

Jon.

