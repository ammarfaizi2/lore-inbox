Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTILWjG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 18:39:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbTILWjG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 18:39:06 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:41113 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S261939AbTILWjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 18:39:04 -0400
Subject: Re: Efficient IPC mechanism on Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Luca Veraldi <luca.veraldi@katamail.com>
Cc: Timothy Miller <miller@techsource.com>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <002201c37960$d9cfc740$f0ae7450@wssupremo>
References: <00f201c376f8$231d5e00$beae7450@wssupremo>
	 <20030909175821.GL16080@Synopsys.COM>
	 <001d01c37703$8edc10e0$36af7450@wssupremo>
	 <20030910064508.GA25795@Synopsys.COM>
	 <015601c3777c$8c63b2e0$5aaf7450@wssupremo>
	 <1063185795.5021.4.camel@laptop.fenrus.com>
	 <01c601c3777f$97c92680$5aaf7450@wssupremo>
	 <20030910114414.B14352@devserv.devel.redhat.com>
	 <01f801c37783$9ead8960$5aaf7450@wssupremo>
	 <20030910121453.B9878@devserv.devel.redhat.com>
	 <024601c37785$e3e07680$5aaf7450@wssupremo>
	 <3F621355.3050009@techsource.com>
	 <002201c37960$d9cfc740$f0ae7450@wssupremo>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063406253.5783.22.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Fri, 12 Sep 2003 23:37:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2003-09-12 at 20:05, Luca Veraldi wrote:
> If you modify the page tables as in my example (and then if you do so only
> for B's pagetable)
> you can be sure the things you're modifying were not present in Firmware
> TLBs, not yet.
> 
> Because those pagetable entries refer to a logical address interval
> you've just allocated in B address space.

They may be present in some form, but you are right the task switch will
flush them in the non SMP case on the x86 platform. In the SMP case it
wont work. 

Alan

