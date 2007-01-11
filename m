Return-Path: <linux-kernel-owner+w=401wt.eu-S965312AbXAKH0y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965312AbXAKH0y (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 02:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965317AbXAKH0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 02:26:53 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:49964 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965312AbXAKH0x convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 02:26:53 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: kvm-devel@lists.sourceforge.net
Subject: Re: [kvm-devel] [RFC] Stable kvm userspace interface
Date: Thu, 11 Jan 2007 08:26:28 +0100
User-Agent: KMail/1.9.5
Cc: Avi Kivity <avi@qumranet.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
References: <45A39A97.5060807@qumranet.com>
In-Reply-To: <45A39A97.5060807@qumranet.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701110826.28535.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
X-Provags-ID2: V01U2FsdGVkX19APi2H+p8I+IZ7EOIkkLInyQcCLjeLhCGdJnNH6QSxAFi4X0ooE+Uw5Si5+oD3V6VRF4m6mbiy87/KwQE9KuEglqGgzyY5t6liQLnosR91zA==
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 January 2007 14:37, Avi Kivity wrote:
> struct kvm_vcpu_area {
>     u32 vcpu_area_size;
>     u32 exit_reason;
> 
>     sigset_t sigmask;  // for use during vcpu execution

Since Jeff brought up the point of 32 bit compatibility:
When this structure is shared between 64 bit kernel and
32 bit user space, you sigmask should be a __u64 in order
to guarantee compatibility.

	Arnd <><
