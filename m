Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270872AbTGQVV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271029AbTGQVV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:21:57 -0400
Received: from [213.13.155.14] ([213.13.155.14]:35346 "EHLO zmail.pt")
	by vger.kernel.org with ESMTP id S270872AbTGQVV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:21:56 -0400
Subject: Re: SET_MODULE_OWNER
From: Ricardo Bugalho <ricardo.b@zmail.pt>
To: davem@redhat.com
Cc: Jeff Garzik <jgarzik@pobox.com>, schlicht@uni-mannheim.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030717125942.7fab1141.davem@redhat.com>
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	 <3F16C190.3080205@pobox.com> <200307171756.19826.schlicht@uni-mannheim.de>
	 <3F16C83A.2010303@pobox.com>  <20030717125942.7fab1141.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1058477803.754.11.camel@ezquiel.nara.homeip.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jul 2003 22:36:43 +0100
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: ricardo.b@zmail.pt
X-Spam-Processed: zmail.pt, Thu, 17 Jul 2003 22:43:19 +0100
	(not processed: spam filter disabled)
X-Return-Path: ricardo.b@zmail.pt
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: ricardo.b@zmail.pt
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-17 at 20:59, David S. Miller wrote:
> On Thu, 17 Jul 2003 12:00:58 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > David?  Does Rusty have a plan here or something?
> 
> It just works how it works and that's it.
> 
> Net devices are reference counted, anything more is superfluous.
> They may be yanked out of the kernel whenever you want.

Just noticed it: I can't unload the module even after bringing the
interface down.
In either case, modprobe hangs and I start getting this message in
syslog:

Jul 17 21:50:44 ezquiel kernel: unregister_netdevice: waiting for eth0
to become free. Usage count = -4

Can't shutdown the system either. Init hangs waiting for modprobe to
die.

-- 
	Ricardo

