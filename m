Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264620AbTFELp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 07:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264622AbTFELp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 07:45:26 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:1802 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264620AbTFELpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 07:45:25 -0400
Date: Thu, 5 Jun 2003 15:58:21 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Margit Schubert-While <margitsw@t-online.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Re: PCI cache line messages 2.4/2.5
Message-ID: <20030605155821.A19365@jurassic.park.msu.ru>
References: <5.1.0.14.2.20030605080244.00af0a30@pop.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5.1.0.14.2.20030605080244.00af0a30@pop.t-online.de>; from margitsw@t-online.de on Thu, Jun 05, 2003 at 08:12:05AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 08:12:05AM +0200, Margit Schubert-While wrote:
> 2.4 gets 0 and sets 128. 2.5 gets 128 and reports it wrong.

2.4 writes 128 without reading it back; 2.5 writes 128, read it back
and gets 0. Thus "not supported" message, which means that you
cannot use MWI on this device.

2.5 and BIOS are correct, 2.4 is not.

Ivan.
