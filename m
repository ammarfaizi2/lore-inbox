Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261653AbTCVAlX>; Fri, 21 Mar 2003 19:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261652AbTCVAlX>; Fri, 21 Mar 2003 19:41:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18072
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261653AbTCVAlW>; Fri, 21 Mar 2003 19:41:22 -0500
Subject: Re: PATCH: Make pci-bios function ids per machine type
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
In-Reply-To: <3E7B7D84.7000108@didntduck.org>
References: <200303212030.h2LKUApv026359@hraefn.swansea.linux.org.uk>
	 <3E7B7D84.7000108@didntduck.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048298651.7229.34.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 22 Mar 2003 02:04:11 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-21 at 21:00, Brian Gerst wrote:
> Wouldn't this be better?
> 
> #ifdef CONFIG_PC9800
> #define PCIBIOS_PCI_FUNCTION_ID 0xcc80
> #else
> #define PCIBIOS_PCI_FUNCTION_ID 0xb100
> #endif
> 
> #define PCIBIOS_PCI_BIOS_PRESENT	PCIBIOS_PCI_FUNCTION_ID+1
> #define PCIBIOS_FIND_PCI_DEVICE		PCIBIOS_PCI_FUNCTION_ID+2

We went for the less ifdef approach. We have mach-foo and it works very
well. If you look at the original you'll also see only some functions
exist on the 9800 so its also better because using an unsupported function
is a compile error not a crash.

We may also yet find other pci bios stuff is weird 8)

