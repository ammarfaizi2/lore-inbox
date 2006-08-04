Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWHDSiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWHDSiS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 14:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWHDSiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 14:38:18 -0400
Received: from gw.goop.org ([64.81.55.164]:25772 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751411AbWHDSiR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 14:38:17 -0400
Message-ID: <44D3941D.7010303@goop.org>
Date: Fri, 04 Aug 2006 11:38:21 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: David Lang <dlang@digitalinsight.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       jeremy@xensource.com, greg@kroah.com, zach@vmware.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, hch@infradead.org,
       jlo@vmware.com, xen-devel@lists.xensource.com, simon@xensource.com,
       ian.pratt@xensource.com
Subject: Re: A proposal - binary
References: <44D1CC7D.4010600@vmware.com> <20060803190605.GB14237@kroah.com>  <44D24DD8.1080006@vmware.com> <20060803200136.GB28537@kroah.com>  <44D2B678.6060400@xensource.com> <20060803211850.3a01d0cc.akpm@osdl.org>  <1154667875.11382.37.camel@localhost.localdomain>  <20060803225357.e9ab5de1.akpm@osdl.org> <1154675100.11382.47.camel@localhost.localdomain> <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz>
In-Reply-To: <Pine.LNX.4.63.0608040944480.18902@qynat.qvtvafvgr.pbz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Lang wrote:
> if it's only a source-level API this implies that when you move your 
> host kernel from 2.6.19 to 2.6.25 you would need to recompile your 
> 2.6.19 guest kernel to support the modifications. where are the 
> patches going to come from to do this?

No, the low-level interface between the kernel is an ABI, which will be 
as stable as your hypervisor author/vendor wants it to be (which is 
generally "very stable").  The question is whether that low-level 
interface is exposed to the rest of the kernel directly, or hidden 
behind a kernel-internal source-level API.

    J
