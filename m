Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271202AbTGWSLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 14:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271197AbTGWSLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 14:11:42 -0400
Received: from chaos.analogic.com ([204.178.40.224]:35969 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S271198AbTGWSLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 14:11:04 -0400
Date: Wed, 23 Jul 2003 14:26:41 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: jw schultz <jw@pegasys.ws>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: ICMP REQUEST
In-Reply-To: <20030723181212.GB15719@pegasys.ws>
Message-ID: <Pine.LNX.4.53.0307231422010.15818@chaos>
References: <E04CF3F88ACBD5119EFE00508BBB212104BCD649@exch-01.noida.hcltech.com>
 <20030723181212.GB15719@pegasys.ws>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jul 2003, jw schultz wrote:

> On Wed, Jul 23, 2003 at 12:53:35PM +0530, Hemanshu Kanji Bhadra, Noida wrote:
> > Hi, All
> >
> > i am developing a  ping program, through my program I get ECHO_REPLY..but I
> > dont get ECHO_REQUEST.
> >
> > is that the ECHO_REQUEST is handled by kernel.?
> >
> > please respond as it is urgent.
>
> In most cases ICMP ECHO_REQUEST is handled by the NIC.  The
> kernel doesn't even see it.  That is why you can ping a
> crashed system; the NIC is still configured.
>

No. It may be handled entirely in an interrupt service routine, but
never by the hardware alone, even the "smart" hardware that does
IP checksumming. There isn't enough information available. The
echo request contains the IP that the caller seeks to respond.
The responder needs to know, not only its IP address, but also the
IP address of all the IPs it's going to ARP (proxy ARP).

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.

