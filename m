Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270819AbTHFSom (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 14:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270821AbTHFSol
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 14:44:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:51719 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S270819AbTHFSof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 14:44:35 -0400
Date: Wed, 6 Aug 2003 19:44:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
Subject: Re: [PATCH 2.6] ToPIC specific init for yenta_socket
Message-ID: <20030806194430.D16116@flint.arm.linux.org.uk>
Mail-Followup-To: Daniel Ritz <daniel.ritz@gmx.ch>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pcmcia <linux-pcmcia@lists.infradead.org>
References: <200308062025.08861.daniel.ritz@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200308062025.08861.daniel.ritz@gmx.ch>; from daniel.ritz@gmx.ch on Wed, Aug 06, 2003 at 08:25:08PM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 08:25:08PM +0200, Daniel Ritz wrote:
> this patch adds override functions for the ToPIC family of controllers.
> also adds the device id for ToPIC100 and (untested) support for zoom
> video for ToPIC97/100.
> 
> tested with start/stop and suspend/resume.

We currently have some fairly serious IRQ problems with yenta at the
moment.  I'm holding all patches until we get this problem resolved -
it seems to be caused by several bad changes over the past couple of
years accumulating throughout the 2.5 series.

Therefore, I don't want to add any further changes into the mix just
yet.

Also, assigning to socket->socket.ops->init modifies the global
yenta_socket_operations structure, which I'm far from happy about.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

