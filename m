Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281748AbRLLSXV>; Wed, 12 Dec 2001 13:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281786AbRLLSXL>; Wed, 12 Dec 2001 13:23:11 -0500
Received: from mail.xmailserver.org ([208.129.208.52]:8461 "EHLO
	mail.xmailserver.org") by vger.kernel.org with ESMTP
	id <S281748AbRLLSXI>; Wed, 12 Dec 2001 13:23:08 -0500
Date: Wed, 12 Dec 2001 10:25:17 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Near CPUs ...
In-Reply-To: <3126105393.1008148452@[10.10.1.2]>
Message-ID: <Pine.LNX.4.40.0112121020040.1564-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Dec 2001, Martin J. Bligh wrote:

> > How to detect CPUs that are "near" ( on the same bus/mb ) on x86/ia64 hardware ?
> > Is the MP configuration data structured in a way that makes you understand
> > this mapping, ie :
>
> IIRC, for HT, cpus with an APICid that only differ in the last bit are paired
> (ie (0,1), (2,3), (3,4) ....)
>
> For systems with clustered APIC ID, the cluster number is the top nibble of the
> logical APICid - CPUs with the same cluster number are in the same node.

This info is good enough for now but i think there should be an abstract
interface inside the kernel to get topology infos.
I looked at SRAT tables, they're good if they'll be a standard w/out M$
patents. Otherwise the ACPI2 _PXM method can be used.




- Davide


