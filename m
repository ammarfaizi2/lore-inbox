Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264394AbTFKLqN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 07:46:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbTFKLqN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 07:46:13 -0400
Received: from mrburns.nildram.co.uk ([195.112.4.54]:44560 "EHLO
	mrburns.nildram.co.uk") by vger.kernel.org with ESMTP
	id S264394AbTFKLqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 07:46:11 -0400
Date: Wed, 11 Jun 2003 12:59:55 +0100
From: Joe Thornber <thornber@sistina.com>
To: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] dm: Repair persistent minors
Message-ID: <20030611115954.GB8862@fib011235813.fsnet.co.uk>
References: <20030611100542.GD2499@fib011235813.fsnet.co.uk> <E19Q2ho-0001NC-00@calista.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E19Q2ho-0001NC-00@calista.inka.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 11, 2003 at 12:19:48PM +0200, Bernd Eckenfels wrote:
> In article <20030611100542.GD2499@fib011235813.fsnet.co.uk> you wrote:
> > Split the dm_create() function into two variants, depending on whether
> > you want the device to have a specific minor number.  This avoids
> > the broken overloading of the minor argument to the old dm_create().
> 
> why dont you just call dm_create_with_minor() from dm_create and skip the
> create_aux function?

Because I'm trying to avoid having a special value to the 'minor' arg
to indicate that we can use any minor.

> the create_aux function is pretty badly named, me
> thinks. you sould at least call it dm_create_aux.

I use the dm_ prefix for external functions.

- Joe
