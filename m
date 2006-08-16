Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbWHPQki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbWHPQki (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 12:40:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932108AbWHPQki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 12:40:38 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:51377 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1751184AbWHPQkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 12:40:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:MIME-Version:Content-Type;
  b=5rAWmEu+do47zdwnLOHedfiaMj5YCfDT9RgLLOOrvlizxWnx8SMcIj69ISJuJHbWCdnOxX4lxKVoDiKy/LzaEx0uKsTrc7TLZ5WNkqJN50fmviKPI9WfeLlAr2PQgN0PBim7VuiUAKT/Y7b9oz/V07GB+B7BjLhkEnXHvz18lE0=  ;
Message-ID: <20060816164036.32867.qmail@web25805.mail.ukl.yahoo.com>
Date: Wed, 16 Aug 2006 16:40:36 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: CROSS_COMPILE issue
To: sam@mars.ravnborg.org
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I met an issue when compiling kernel 2.6.18-rc4. I 
cross compile the kernel for a MIPS target on a PC.
MIPS architecture assigns CROSS_COMPILE in
its arch/mips/Makefile but it is not included by the 
main Makefile from the begining. So one of the
consequence is that CC variable is not correctly
set until arch's Makefile is included. It's set to "gcc"
since CROSS_COMPILE is still not defined instead
of "mips-linux-gcc". During this time CC variable is 
used to setup CFLAGS for example.

is it something known ?

thanks

Francis



