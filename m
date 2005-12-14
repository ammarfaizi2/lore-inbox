Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751372AbVLNFhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751372AbVLNFhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 00:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751374AbVLNFhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 00:37:15 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59016 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751372AbVLNFhN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 00:37:13 -0500
Date: Wed, 14 Dec 2005 00:37:08 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       netdev@vger.kernel.org
Subject: Re: [PATCH] skge: get rid of warning on race
Message-ID: <20051214053708.GA10486@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Stephen Hemminger <shemminger@osdl.org>,
	Jeff Garzik <jgarzik@pobox.com>, netdev@vger.kernel.org
References: <200512130559.jBD5xUjf015319@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512130559.jBD5xUjf015319@hera.kernel.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2005 at 09:59:30PM -0800, Linux Kernel wrote:
 > tree 987cfbd2134b82bea55c55fa17bd70d29df70458
 > parent 0e670506668a43e1355b8f10c33d081a676bd521
 > author Stephen Hemminger <shemminger@osdl.org> Wed, 07 Dec 2005 07:01:49 -0800
 > committer Jeff Garzik <jgarzik@pobox.com> Tue, 13 Dec 2005 09:33:03 -0500
 > 
 > [PATCH] skge: get rid of warning on race
 > 
 > Get rid of warning in case of race with ring full and lockless
 > tx on the skge driver. It is possible to be in the transmit
 > routine with no available slots and already stopped.
 > 
 > Signed-off-by: Stephen Hemminger <shemminger@osdl.org>
 > Signed-off-by: Jeff Garzik <jgarzik@pobox.com>

You've traded a warning for something more serious :)

now I get...

drivers/net/skge.ko needs unknown symbol netif_stopped


		Dave

