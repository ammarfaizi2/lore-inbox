Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268150AbRHAUpL>; Wed, 1 Aug 2001 16:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268151AbRHAUox>; Wed, 1 Aug 2001 16:44:53 -0400
Received: from quark.didntduck.org ([216.43.55.190]:52494 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S268150AbRHAUoc>; Wed, 1 Aug 2001 16:44:32 -0400
Message-ID: <3B686A1F.B2409245@didntduck.org>
Date: Wed, 01 Aug 2001 16:44:15 -0400
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Svein Erling Seldal <Svein.Seldal@edcom.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: readw() access
In-Reply-To: <NEBBLKFNEDOFBCDCJMLKCEAKCEAA.Svein.Seldal@edcom.no>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Svein Erling Seldal wrote:
> 
> Hello,
> 
> I'm trying to port a driver from 2.2.x to 2.4.x where I previously has used
> readw() to read the contents of the memory-adresses 0x408-0x40c (Where the
> BIOS gives you the adr. for the par-ports.) But on 2.4.x readw(0x408) Oops:
> 
> "Unable to handle kernel NULL pointer dereference at virtual address
> 00000408"
> 
> How do you read a memory-address like this?
> 
> Svein Erling Seldal

Use isa_readw() or ioremap().

--

				Brian Gerst
