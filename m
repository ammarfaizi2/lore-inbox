Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUHYNEh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUHYNEh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 09:04:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUHYNEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 09:04:33 -0400
Received: from nene.qinetiq.com ([192.102.214.10]:1992 "HELO nene.qinetiq.com")
	by vger.kernel.org with SMTP id S267334AbUHYNEb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 09:04:31 -0400
Subject: Re: 2.6.8.1: ip auto-config accepts wrong packages
From: Mark Broadbent <markb@wetlettuce.com>
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <412C5E80.8050603@bio.ifi.lmu.de>
References: <412C5E80.8050603@bio.ifi.lmu.de>
Message-Id: <1093439062.25506.12.camel@mbpc.signal.qinetiq.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 25 Aug 2004 14:04:23 +0100
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-25 at 10:40, Frank Steiner wrote:
> Hi,
> 
> we are running a diskless client system using kernel ip autoconfiguration.
> The problem is that sometimes clients accept packages that are meant
> for other clients.
> 
> ...
>
> I wasn't able to reproduce the problem from the command line using
> dhclient, so I'm not sure if this is a general problem with dhcp or
> a problem in the ip-autoconfig code of the client.

Try enabling the debug messaging in the ipconfig code.  Edit the file
net/ipv4/ipconfig.c just below the #include's and change the line 

#undef IPCONFIG_DEBUG

to

#define IPCONFIG_DEBUG

and rebuild.  Post the outputs from both machines when you see this
effect again.

> Server and Clients both run 2.6.8.1 and the dhcp server is the ISC DHCP
> server version 3.0.1rc12.


Thanks
Mark

> cu,
> Frank
