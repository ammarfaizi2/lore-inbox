Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932163AbWCIXwt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932163AbWCIXwt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932117AbWCIXwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:52:49 -0500
Received: from mx.pathscale.com ([64.160.42.68]:649 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932163AbWCIXwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:52:47 -0500
Subject: Re: [PATCH 9 of 20] ipath - char devices for diagnostics and
	lightweight subnet management
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Roland Dreier <rdreier@cisco.com>
Cc: rolandd@cisco.com, gregkh@suse.de, akpm@osdl.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, openib-general@openib.org
In-Reply-To: <ada8xrjfbd8.fsf@cisco.com>
References: <eac2ad3017b5f160d24c.1141922822@localhost.localdomain>
	 <ada8xrjfbd8.fsf@cisco.com>
Content-Type: text/plain
Organization: PathScale, Inc.
Date: Thu, 09 Mar 2006 15:52:47 -0800
Message-Id: <1141948367.10693.53.camel@serpentine.pathscale.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-09 at 15:26 -0800, Roland Dreier wrote:

> Similarly what protects against another process opening the device
> right after the ipath_sma_alive = 0 setting, but before you do all the
> cleanup that's after that?

This is fixed by the stuff I just did in response to your earlier
message.

> And what protects against a hot unplug of a device after the test of s
> against ipath_max?

We don't support hotplugged devices at the moment.  If you're asking
whether an rmmod at the wrong time could cause something bad to happen,
I don't *think* so.

	<b

