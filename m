Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271058AbTGQV3U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 17:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271289AbTGQV3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 17:29:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36838 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S271058AbTGQV3T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 17:29:19 -0400
Date: Thu, 17 Jul 2003 14:34:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: schlicht@uni-mannheim.de, ricardo.b@zmail.pt, linux-kernel@vger.kernel.org
Subject: Re: SET_MODULE_OWNER
Message-Id: <20030717143424.544879f8.davem@redhat.com>
In-Reply-To: <3F170BB7.5030806@pobox.com>
References: <1058446580.18647.11.camel@ezquiel.nara.homeip.net>
	<3F16C190.3080205@pobox.com>
	<200307171756.19826.schlicht@uni-mannheim.de>
	<3F16C83A.2010303@pobox.com>
	<20030717125942.7fab1141.davem@redhat.com>
	<3F170589.50005@pobox.com>
	<20030717131902.76c68c56.davem@redhat.com>
	<3F170BB7.5030806@pobox.com>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003 16:48:55 -0400
Jeff Garzik <jgarzik@pobox.com> wrote:

> rmmod is now completely pointless, and developers now have one less 
> useful tool in their toolbox.
> 
> I code all the time doing "modprobe ; test ; rmmod", and that's now 
> impossible.

I fail to see the problem with having rmmod do exactly
what you ask it to do.

If there is some refcounting bug, you will see it, because rmmod will
spin sleeping and waiting for all the net_dev refcounts to go away.
This will spit out kernel messages and only occur when there is a bug
in the kernel somewhere.
