Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271420AbTG2MJi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 08:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271419AbTG2MJi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 08:09:38 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:60655 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S271688AbTG2MHx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 08:07:53 -0400
Subject: Re: OOPS 2.6.0-test2, modprobe i810fb
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andrew Morton <akpm@osdl.org>
Cc: "S. Anderson" <sa@xmission.com>, pavel@xal.co.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       adaplas@pol.net
In-Reply-To: <20030729005456.495c89c4.akpm@osdl.org>
References: <20030728171806.GA1860@xal.co.uk>
	 <20030728201954.A16103@xmission.xmission.com>
	 <20030728202600.18338fa9.akpm@osdl.org>
	 <20030728231812.A20738@xmission.xmission.com>
	 <20030728225914.4f299586.akpm@osdl.org>
	 <20030729012417.A18449@xmission.xmission.com>
	 <20030729005456.495c89c4.akpm@osdl.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059479872.2921.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 29 Jul 2003 13:00:40 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-29 at 08:54, Andrew Morton wrote:
> wtf?  So the memory at d094ee7c (which contains i810fb's pci table) became
> unmapped from kernel virtual address space as a result of you inserting
> your carbus card.
> 
> I am impressed.

This makes complete sense actually - its marked __initdata. Remove the
__initdata and try again or mark it __devinitdata ?

