Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261969AbTEXCc5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 22:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262300AbTEXCc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 22:32:57 -0400
Received: from smtp013.mail.yahoo.com ([216.136.173.57]:23313 "HELO
	smtp013.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261969AbTEXCc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 22:32:56 -0400
Message-ID: <3ECEDCCD.7070306@yahoo.com>
Date: Fri, 23 May 2003 19:45:33 -0700
From: Lars <lhofhansl@yahoo.com>
Organization: What? Organized??
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solved!

I looked at the 2.4.20 output and saw ICH2M mentioned in the
output. I then grepped the drivers/ide/pci files for ICH2M
and found I just had to enable CONFIG_BLK_DEV_PIIX.

In my defense I can only say that the Configure.help
stated that this option only enables extended PIO modes.

So for the record: A Dell Inspiron 8100 Laptop needs
the CONFIG_BLK_DEV_PIIX to enable DMA.

-- Lars

