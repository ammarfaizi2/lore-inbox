Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750882AbWC2Tto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750882AbWC2Tto (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 14:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbWC2Tto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 14:49:44 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:10370 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1750852AbWC2Ttn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 14:49:43 -0500
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7C75FBEB-F962-4860-A797-AC6B454D6E6E@kernel.crashing.org>
Cc: David Brownell <david-b@pacbell.net>,
       spi-devel-general@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: SPI bus driver synchronous support
Date: Wed, 29 Mar 2006 13:49:48 -0600
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was wondering if there was any thought to providing a mechanism for  
SPI bus drivers to implement a direct synchronous interface so we  
don't have to use wait_for_completion.

The case I have is I need to talk to a microcontroller connected over  
SPI.  I'd like to be able to issue a command to the microcontroller  
in a MachineCheck handler before the system reboots.  I need a truly  
synchronous interface opposed to one fronting the async interface.

Also, who is the maintainer for the SPI subsystem?

thanks

- kumar


