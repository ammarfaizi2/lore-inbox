Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbVC1SQV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbVC1SQV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 13:16:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVC1SQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 13:16:21 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:11240 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261899AbVC1SQT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 13:16:19 -0500
From: David Brownell <david-b@pacbell.net>
To: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: klists and struct device semaphores
Date: Mon, 28 Mar 2005 10:16:15 -0800
User-Agent: KMail/1.7.1
Cc: Alan Stern <stern@rowland.harvard.edu>,
       Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0503261152160.13772-100000@netrider.rowland.org> <Pine.LNX.4.50.0503280856210.28120-100000@monsoon.he.net>
In-Reply-To: <Pine.LNX.4.50.0503280856210.28120-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503281016.15374.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 28 March 2005 9:44 am, Patrick Mochel wrote:

> How is this related to (8) above? Do you need some sort of protected,
> short path through the core to add the device, but not bind it or add it
> to the PM core?

Erm, why is there a distinction between "adding device" and "adding it
to the PM core"?  That's a conceptual problem right there.  There
should be no distinctio.  (But it does make eminent sense to be able
to add a device without necessarily binding it to a driver, since
the "unbound driver" state is all over the place.)

- Dave

