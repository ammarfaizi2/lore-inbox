Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbWAIMLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbWAIMLe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 07:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWAIMLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 07:11:33 -0500
Received: from smtp.osdl.org ([65.172.181.4]:17375 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932275AbWAIMLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 07:11:32 -0500
Date: Mon, 9 Jan 2006 04:11:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: Folkert van Heusden <folkert@vanheusden.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.15] running tcpdump on 3c905b causes freeze (reproducable)
Message-Id: <20060109041114.6e797a9b.akpm@osdl.org>
In-Reply-To: <20060108114305.GA32425@vanheusden.com>
References: <20060108114305.GA32425@vanheusden.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Folkert van Heusden <folkert@vanheusden.com> wrote:
>
> My system freezes (crashes) when I run tcpdump on the interface
>  connected to a 3c905b card.

Works for me with a 3c980-TX.  I can dig out a 905b.

Please send the exact commands which you're using to demonstrate this -
sufficient info for me to get as close as possible to what you're doing.

Have you tried enabling the NMI watchdog?  Enable CONFIG_X86_LOCAL_APIC and
boot with `nmi_watchdog=1' on the command line, make sure that the NMI line
of /proc/interrupts is incrementing.

