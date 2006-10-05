Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932129AbWJEP1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932129AbWJEP1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbWJEP1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:27:09 -0400
Received: from terminus.zytor.com ([192.83.249.54]:49083 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932132AbWJEP1F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:27:05 -0400
Message-ID: <45252402.6010300@zytor.com>
Date: Thu, 05 Oct 2006 08:25:54 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, magnus.damm@gmail.com,
       lwang@redhat.com, dzickus@redhat.com, maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>	<20061003172511.GL3164@in.ibm.com>	<20061003201340.afa7bfce.akpm@osdl.org>	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>	<20061004214403.e7d9f23b.akpm@osdl.org>	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com> <20061004233137.97451b73.akpm@osdl.org>
In-Reply-To: <20061004233137.97451b73.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Thu, 05 Oct 2006 00:13:12 -0600
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
>> Do things work better if you don't specify a vga=xxx mode?
> 
> yes, without vga=0x263 it boots.

vga= actually patches a specific offset in the boot sector.  We don't 
actually have 512 bytes, we have some 500-ish bytes plus a small patch 
area at the end.

	-hpa
