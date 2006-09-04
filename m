Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751307AbWIDCep@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbWIDCep (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Sep 2006 22:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbWIDCep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Sep 2006 22:34:45 -0400
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:41844 "HELO
	smtp113.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751307AbWIDCeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Sep 2006 22:34:44 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:Date:From:To:Subject:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=TSexgzj12B/Yt9exNdj4JlZ4te4Rg9U8SvjVXgSSH/IVfe8/K0yFSVTjK0V66itBnXFCDI4vAgABzO0WZ7pFhHFHZuQR9fEQZA1puT+XiU9eb8lkk5rIDZ1tKP63+v/c2O3r6QlFXJ6AUWOFyrdFNgGii7xRUzCl2t7w2RYNCwM=  ;
Date: Sun, 03 Sep 2006 19:34:40 -0700
From: David Brownell <david-b@pacbell.net>
To: dtor@insightbb.com
Subject: Re: [patch/RFC 2.6.18-rc] platform_device_probe(), to conserve memory
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org, greg@kroah.com
References: <200609031823.05560.david-b@pacbell.net>
 <200609032134.30195.dtor@insightbb.com>
In-Reply-To: <200609032134.30195.dtor@insightbb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20060904023440.E7848195C95@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dmitry Torokhov <dtor@insightbb.com>
> Date: Sun, 3 Sep 2006 21:34:29 -0400
>
> On Sunday 03 September 2006 21:23, David Brownell wrote:
> > This defines a new platform_driver_probe() method allowing the driver's
> > probe() method, and its support code+data, to safely live in __init
> > sections for common system configurations.
> > 
>
> If you do this you also need to kill drivers bind/unbind attributes
> to show that dynamic [un]binding is not supported.

Unbinding hasn't changed; so if that attribute breaks because of this,
it was already broken.

It might be important that drv->probe() be replaced with something
that always fails though, since it seems there's an odd assumption
that not having a probe() means the driver works for any device...

- Dave


-- 
VGER BF report: H 1.38493e-10
