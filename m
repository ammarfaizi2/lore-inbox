Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264198AbTKKHSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 02:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264260AbTKKHSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 02:18:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:9186 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264198AbTKKHSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 02:18:43 -0500
Date: Mon, 10 Nov 2003 23:12:38 -0800
From: "David S. Miller" <davem@redhat.com>
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
Cc: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: net/packet/af_packet.c:{1057,1073}: flags vs. msg->flags
Message-Id: <20031110231238.4742a158.davem@redhat.com>
In-Reply-To: <3FAF7236.7020209@softhome.net>
References: <3FAF7236.7020209@softhome.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Nov 2003 12:10:46 +0100
"Ihar 'Philips' Filipau" <filia@softhome.net> wrote:

>     On line 1057 we have: "msg->msg_flags|=MSG_TRUNC;" to indicate that 
> message was truncated.
> 
>     But on line 1073, where we make return status to user, we check 
> against user suplied flags, but NOT msg->msg_flags.
> 
>     It looks like obvious typo.

Indeed, you're right.

Thanks for the report, I'll fix this in both 2.4.x and 2.6.x
