Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWGRKVb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWGRKVb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWGRKVb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:21:31 -0400
Received: from mta2.cl.cam.ac.uk ([128.232.0.14]:34997 "EHLO mta2.cl.cam.ac.uk")
	by vger.kernel.org with ESMTP id S932162AbWGRKVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:21:30 -0400
In-Reply-To: <1153216752.3038.20.camel@laptopd505.fenrus.org>
References: <20060718091807.467468000@sous-sol.org> <20060718091949.565211000@sous-sol.org> <1153216752.3038.20.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <be0546baf787698b3c9edd4c27c3d9ce@cl.cam.ac.uk>
Content-Transfer-Encoding: 7bit
Cc: virtualization@lists.osdl.org, Jeremy Fitzhardinge <jeremy@goop.org>,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>,
       Andrew Morton <akpm@osdl.org>
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Subject: Re: [RFC PATCH 04/33] Add XEN config options and disable unsupported config options.
Date: Tue, 18 Jul 2006 11:21:18 +0100
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.624)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 18 Jul 2006, at 10:59, Arjan van de Ven wrote:

>>  config KEXEC
>>  	bool "kexec system call (EXPERIMENTAL)"
>> -	depends on EXPERIMENTAL
>> +	depends on EXPERIMENTAL && !X86_XEN
>>  	help
>>  	  kexec is a system call that implements the ability to shutdown 
>> your
>>  	  current kernel, and to start another kernel.  It is like a reboot
>
> hmmm why is kexec incompatible with xen? Don't you want to support 
> crash
> dumps from guests?

There are kexec patches for Xen which haven't yet been merged into our 
tree. Even without that we can take coredumps of guests from the 
control VM, without the guest's active involvement.

  -- Keir

