Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751296AbWEFIqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbWEFIqx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 May 2006 04:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751298AbWEFIqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 May 2006 04:46:53 -0400
Received: from ns.suse.de ([195.135.220.2]:39393 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751296AbWEFIqw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 May 2006 04:46:52 -0400
From: Andi Kleen <ak@suse.de>
To: Alexey Toptygin <alexeyt@freeshell.org>
Subject: Re: [PATCH] sendfile compat functions on x86_64 and ia64
Date: Sat, 6 May 2006 10:46:24 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, tony.luck@intel.com
References: <Pine.NEB.4.62.0605050030200.18795@norge.freeshell.org> <200605052328.21370.ak@suse.de> <Pine.NEB.4.62.0605052145140.25706@ukato.freeshell.org>
In-Reply-To: <Pine.NEB.4.62.0605052145140.25706@ukato.freeshell.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605061046.24315.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I agree that this test will pass if we change the declaration of count to 
> u32 in sys32_sendfile,

Again the compat layer is only supposed to be as good as a native 32bit
kernel. You try to make it better by allowing values that a 32bit
kernel wouldn't allow. But that's not its goal - it just wants to be 
as compatible as possible.

> The only thing my patch does other than changing the signedness of count 
> in the declaration of x86_64 sys32_sendfile is relabelling the types of 
> offset and count to compat_off_t and compat_size_t. The underlying types 
> shouldn't change as a result, but I think this way what is going on is 
> much clearer: the compat_ types were defined for exactly this scenario of 
> 64 bit kernel functions getting off_t and size_t values from a 32 bit 
> userland, no?

The goal isn't to be clear, the goal is to be compatible.

Please stop continue arguing about this - it's useless.

-Andi
