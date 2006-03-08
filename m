Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964860AbWCHNIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbWCHNIp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 08:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751054AbWCHNIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 08:08:45 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47515 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750991AbWCHNIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 08:08:44 -0500
Subject: Re: Memory barriers and spin_unlock safety
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       akpm@osdl.org, linux-arch@vger.kernel.org, bcrl@linux.intel.com,
       matthew@wil.cx, linux-kernel@vger.kernel.org, mingo@redhat.com,
       linuxppc64-dev@ozlabs.org, jblunck@suse.de
In-Reply-To: <Pine.LNX.4.64.0603071930530.32577@g5.osdl.org>
References: <32518.1141401780@warthog.cambridge.redhat.com>
	 <Pine.LNX.4.64.0603030823200.22647@g5.osdl.org>
	 <17417.29375.87604.537434@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0603040914160.22647@g5.osdl.org>
	 <17422.19865.635112.820824@cargo.ozlabs.ibm.com>
	 <Pine.LNX.4.64.0603071930530.32577@g5.osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 08 Mar 2006 13:12:57 +0000
Message-Id: <1141823577.7605.31.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-03-07 at 19:54 -0800, Linus Torvalds wrote:
> Close, yes. HOWEVER, it's only really ordered wrt the "innermost" bus. I 
> don't think PCI bridges are supposed to post PIO writes, but a x86 CPU 
> basically won't stall for them forever.

The bridges I have will stall forever. You can observe this directly if
an IDE device decides to hang the IORDY line on the IDE cable or you
crash the GPU on an S3 card.

Alan

