Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287948AbSABUty>; Wed, 2 Jan 2002 15:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287966AbSABUtj>; Wed, 2 Jan 2002 15:49:39 -0500
Received: from quark.didntduck.org ([216.43.55.190]:48136 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S287948AbSABUsZ>; Wed, 2 Jan 2002 15:48:25 -0500
Message-ID: <3C3371B3.F061BB52@didntduck.org>
Date: Wed, 02 Jan 2002 15:46:43 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102151539.A14925@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Is there any way to safely probe a PCI motherboard to determine whether
> or not it has ISA cards present, or ISA card slots?
> 
> Note: the question is *not* about a probe for whether the board has an ISA
> bridge, but a probe for the presence of actual ISA cards (or slots).
> 
> (Yes, I'm working on a smart autoconfigurator.  It's a development of
> Giacomo Catenazzi's code, but able to use the CML2 deduction engine.)

The problem with ISA is that it is too simple of a bus, and is virtually
transparent.  It has no auto-configuration/detection standard (except
ISAPNP).  Each card is detected in a different way, and you have the
problem with probing unknown ports causing potential crashes.  Detecting
the ISA slots is impossible, except possibly from the BIOS.

--

				Brian Gerst
