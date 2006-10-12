Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751028AbWJLSJM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbWJLSJM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 14:09:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbWJLSJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 14:09:12 -0400
Received: from smtp106.sbc.mail.mud.yahoo.com ([68.142.198.205]:37491 "HELO
	smtp106.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751028AbWJLSJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 14:09:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=EnvGK3nj6Kbv3ViuAvX8c2RNe4bCRBZxyAOAElM+uVEhKpqRbkrSEV8cD/q7KgurCthKxXp5fawIZiN5m5mQeWYbe37oM2PInF5GISBK0YCBDju1ATDAa7YsmEdK/mO2EHnsV6zoebsdCldypWSCghHtzuisS8TM5O9ACnZ4cj4=  ;
From: David Brownell <david-b@pacbell.net>
To: Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] SPI: improve sysfs compiler complaint handling
Date: Thu, 12 Oct 2006 11:08:59 -0700
User-Agent: KMail/1.7.1
Cc: dbrownell@users.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <20061012014920.GA13000@havoc.gtf.org>
In-Reply-To: <20061012014920.GA13000@havoc.gtf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610121108.59727.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 October 2006 6:49 pm, Jeff Garzik wrote:

> The compiler complains, even with the "(void)".

> -	(void) device_for_each_child(master->cdev.dev, NULL, __unregister);

Sure seems like a compiler bug to me.  For over two decades, casting
a value into the void has been a standard idiom for saying "ignore
that value" ... ISTR using it to get rid of "unused value" warnings
with LINT on BSD 4.1 systems.

Does anyone know why the GCC folk have decided to go against decades
of common practice here???

- Dave

