Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261337AbVETFSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261337AbVETFSg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 01:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261338AbVETFSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 01:18:36 -0400
Received: from smtp816.mail.sc5.yahoo.com ([66.163.170.2]:39031 "HELO
	smtp816.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261337AbVETFSd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 01:18:33 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc4] Add EXPORT_SYMBOL for hotplug_path
Date: Fri, 20 May 2005 00:18:23 -0500
User-Agent: KMail/1.8
Cc: Greg KH <greg@kroah.com>, Tom Rini <trini@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
References: <20050519164323.GK3771@smtp.west.cox.net> <20050520051839.GB10394@kroah.com>
In-Reply-To: <20050520051839.GB10394@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505200018.24129.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 20 May 2005 00:18, Greg KH wrote:
> On Thu, May 19, 2005 at 09:43:23AM -0700, Tom Rini wrote:
> > If CONFIG_INPUT is set as a module, it will not load as hotplug_path is
> > not a defined symbol.  Trivial fix is to EXPORT_SYMBOL hotplug_path.
> > 
> > Signed-off-by: Tom Rini <trini@kernel.crashing.org>
> 
> Ick, no, I thought we got rid of that usage.  no one should be calling
> hotplug on their own, lots of bad things happen to udevd and HAL if they
> do.
> 
> What caused the input code to be added back into the kernel?  I'll try
> to go track that down...
>

The change never made it into the kernel. And I need to finish proper
input_dev sysfs conversion...

-- 
Dmitry
