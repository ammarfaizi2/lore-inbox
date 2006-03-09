Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWCIXjq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWCIXjq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:39:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932170AbWCIXjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:39:45 -0500
Received: from mx.pathscale.com ([64.160.42.68]:43911 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932164AbWCIXjo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:39:44 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <adalkvjfbo0.fsf@cisco.com>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <adalkvjfbo0.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:39:41 -0800
Message-Id: <1141947581.10693.45.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:20 -0800, Roland Dreier wrote:

> I've never understood what forces you to maintain two separate SMAs.
> Why can't you pick one of the two SMAs and use that unconditionally?

Three reasons.

      * OpenSM wasn't usable when we wrote our SMA.  We have customers
        using ours now, so we have to support it.
      * Our SMA does some setup for the layered ethernet emulation
        driver.
      * Our SMA works without an IB stack of any kind present.

	<b

