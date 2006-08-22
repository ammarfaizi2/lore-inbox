Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWHVPOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWHVPOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWHVPOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:14:05 -0400
Received: from gw.goop.org ([64.81.55.164]:10160 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S932300AbWHVPOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:14:02 -0400
Message-ID: <44EB1F37.6030902@goop.org>
Date: Tue, 22 Aug 2006 08:13:59 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Ian Campbell <Ian.Campbell@xensource.com>, Andrew Morton <akpm@osdl.org>,
       Ian Pratt <ian.pratt@xensource.com>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Chris Wright <chrisw@sous-sol.org>,
       Virtualization <virtualization@lists.osdl.org>,
       Christoph Lameter <clameter@sgi.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1 of 1] x86_64: Put .note.* sections into a PT_NOTE	segment
 in vmlinux II
References: <1156256777.5091.93.camel@localhost.localdomain> <200608221659.18896.ak@suse.de>
In-Reply-To: <200608221659.18896.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Sorry I tried to apply it, but at least 2.6.18rc4 mainline (which my tree
> is based on) doesn't have a NOTES macro so it doesn't link
>
> I dropped the NOTES addition for now, presumably it will need to be readded
> later.

Yes, Ian's patch is incremental on top of mine, which defines the NOTES 
macro in include/asm-generic/vmlinux.lds.h:

#define NOTES                                                           \
                .notes : { *(.note.*) } :note


    J
