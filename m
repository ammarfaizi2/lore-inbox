Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264750AbTF3Huy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 03:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263918AbTF3Huy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 03:50:54 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15887 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263777AbTF3Huw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 03:50:52 -0400
Date: Mon, 30 Jun 2003 09:05:07 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Paul Rolland <rol@as2917.net>
Cc: "'Chris Friesen'" <cfriesen@nortelnetworks.com>, paulus@samba.org,
       linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [BUG]:   problem when shutting down ppp connection since 2.5.70
Message-ID: <20030630090507.A32593@flint.arm.linux.org.uk>
Mail-Followup-To: Paul Rolland <rol@as2917.net>,
	'Chris Friesen' <cfriesen@nortelnetworks.com>, paulus@samba.org,
	linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org,
	linux-net@vger.kernel.org
References: <3EFFA1EA.7090502@nortelnetworks.com> <005e01c33ecd$e20ce6e0$4100a8c0@witbe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <005e01c33ecd$e20ce6e0$4100a8c0@witbe>; from rol@as2917.net on Mon, Jun 30, 2003 at 08:07:25AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 30, 2003 at 08:07:25AM +0200, Paul Rolland wrote:
> > Jun 29 17:18:39 doug kernel: unregister_netdevice: waiting 
> > for ppp0 to 
> > become free. Usage count = 1
> 
> Interestingly, I've got the same with device tun0 on my box, and
> it appeared at the same time.
> 2.5.70 was really blocking as it even prevented a normal shutdown
> of the box :-(

People with PCMCIA cards have been reporting the same thing.  It sounds
like something's up with the netdev layer, and it has persisted until
2.5.73 thus far.

Note that it helps to post such messages to the linux-net lists; some
of the net people don't read lkml.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

