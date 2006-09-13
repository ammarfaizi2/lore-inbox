Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbWIMOrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbWIMOrA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750896AbWIMOq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:46:59 -0400
Received: from outbound2.mail.tds.net ([216.170.230.92]:11200 "EHLO
	outbound2.mail.tds.net") by vger.kernel.org with ESMTP
	id S1750808AbWIMOq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:46:59 -0400
Subject: Re: Error binding socket: address already in use
From: "David M. Lloyd" <dmlloyd@flurg.com>
To: Peter Lezoch <pledr@t-online.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1GNVuW-02KMfw0@fwd29.sul.t-online.de>
References: <1GNVuW-02KMfw0@fwd29.sul.t-online.de>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 09:46:40 -0500
Message-Id: <1158158800.11559.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 14:41 +0000, Peter Lezoch wrote:
> Hi,
> killing a server task that is operating on a UDP socket( AF_INET, SOCK_DGRAM, IPPROTO_UDP ), leaves the socket in an unclosed state. A subsequently started task, that wants to use the same port, gets from bind above error message.This is, in my opinion, wrong behavior, because of the connectionless nature of UDP. Only reboot solves this situation. It looks, as if in net/socket.c, TCP and UDP are handled in the same way without taking into account the different nature of the protocols?!
> How can I overcome this problem ?

Perhaps SO_REUSEADDR is what you're looking for?

man 7 socket

- DML

