Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266493AbUBEUVW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:21:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266422AbUBEUVW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:21:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27561 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266493AbUBEUVL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:21:11 -0500
Message-ID: <4022A5A9.7010105@pobox.com>
Date: Thu, 05 Feb 2004 15:20:57 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cbs@cts.ucla.edu
CC: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, Mirko Lindner <mlindner@syskonnect.de>
Subject: Re: oops w/ 2.4.23, possibly sk98lin related (fwd)
References: <Pine.LNX.4.58L.0402051309580.9788@logos.cnet>
In-Reply-To: <Pine.LNX.4.58L.0402051309580.9788@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Trace; c011c12c <__run_task_queue+60/70>
> Trace; c0137c38 <__wait_on_buffer+70/98>
> Trace; c0137e4a <wait_for_buffers+6e/94>
> Trace; c0137e95 <wait_for_locked_buffers+25/38>
> Trace; c0137ee0 <sync_buffers+38/48>
> Trace; c0138053 <fsync_dev+73/7c>
> Trace; c01b57da <go_sync+12a/144>
> Trace; c01b5859 <do_emergency_sync+65/fc>
> Trace; c0116fe4 <panic+104/108>
> Trace; c011a625 <do_exit+2d/2e4>
> Trace; c01077bc <do_invalid_op+0/90>
> Trace; c010759e <die+6a/6c>
> Trace; c010783e <do_invalid_op+82/90>
> Trace; c022263b <skb_over_panic+2b/3c>
> Trace; c01ada32 <vt_console_print+2c6/2dc>
> Trace; c0107094 <error_code+34/3c>
> Trace; d08aea85 <[sk98lin]XmitFrame+b5/1e0>
> Trace; c022263b <skb_over_panic+2b/3c>
> Trace; d08aea85 <[sk98lin]XmitFrame+b5/1e0>
> Trace; d08aea8d <[sk98lin]XmitFrame+bd/1e0>
> Trace; d08aea85 <[sk98lin]XmitFrame+b5/1e0>
> Trace; d08ae970 <[sk98lin]SkGeXmit+60/c0>
> Trace; c022fa4d <qdisc_restart+6d/184>
> Trace; c022658d <dev_queue_xmit+139/314>
> Trace; c023b269 <ip_finish_output2+c5/124>
> Trace; c022f1e3 <nf_hook_slow+103/180>
> Trace; c0239db5 <ip_output+175/180>
> Trace; c023b1a4 <ip_finish_output2+0/124>
> Trace; c023a15d <ip_queue_xmit+39d/4ec>
> Trace; c024a65c <tcp_transmit_skb+414/568>
> Trace; c024a704 <tcp_transmit_skb+4bc/568>
> Trace; c02222f0 <sock_def_readable+38/68>
> Trace; c024b154 <tcp_write_xmit+174/2bc>
> Trace; c024bf2a <tcp_send_fin+1a6/280>
> Trace; c0241f85 <tcp_close+2c9/820>
> Trace; c0221873 <sk_free+6f/78>
> Trace; c025c1aa <inet_release+4a/58>
> Trace; c021f3ec <sock_release+14/5c>
> Trace; c021f903 <sock_close+27/3c>
> Trace; c0137909 <fput+55/100>
> Trace; c013659e <filp_close+a6/b4>
> Trace; c0119f39 <put_files_struct+61/c8>
> Trace; c011a70e <do_exit+116/2e4>
> Trace; c011a904 <sys_wait4+0/3b8>
> Trace; c0106fa3 <system_call+33/38>


Can you give 2.4.25-rc1 a try?  I've also forwarded your oops trace to 
the sk98lin maintainer (CC'd).

	Jeff



