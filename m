Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266013AbTIJXc5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 19:32:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266028AbTIJXc5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 19:32:57 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:37127 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S266013AbTIJXc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 19:32:56 -0400
Date: Thu, 11 Sep 2003 00:32:47 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: [RFC] add kobject to struct module
Message-ID: <20030911003247.V30046@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>, rusty@rustcorp.com.au,
	linux-kernel@vger.kernel.org
References: <20030909222421.GA7703@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030909222421.GA7703@kroah.com>; from greg@kroah.com on Tue, Sep 09, 2003 at 03:24:21PM -0700
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 09, 2003 at 03:24:21PM -0700, Greg KH wrote:
> A while ago we had talked about adding a kobject to struct module.  By
> doing this we add support for module paramaters and other module info to
> be exported in sysfs.  So here's a patch that does this that is against
> 2.6.0-test4 (it applies with some fuzz, sorry.)

Please excuse my short-sightedness, but I think the following points
haven't been thought deeply enough:

- modules which use their parameters on initialisation only once.
  (eg, 3c59x "full_duplex" parameter)

- Also, what about module parameters which modules aren't expecting to
  change beneath themselves? (eg, all the watchdog modules)

- Are we opening the floodgates for another round of races and driver
  updates?

-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
