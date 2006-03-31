Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWCaRbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWCaRbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 12:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751059AbWCaRbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 12:31:16 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:58647 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S1751022AbWCaRbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 12:31:14 -0500
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1B2FA58D-1F7F-469E-956D-564947BDA59A@kernel.crashing.org>
Cc: spi-devel-general@lists.sourceforge.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: question on spi_bitbang
Date: Fri, 31 Mar 2006 11:31:18 -0600
To: David Brownell <david-b@pacbell.net>
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

I'm looking at using spi_bitbang for a SPI driver and was trying to  
understand were the right point is to handle MODE switches.

There are 4 function pointers provided for each mode.  My controller  
HW has a mode register which allows setting clock polarity and clock  
phase.  I assume what I want is in my chipselect() function is to set  
my mode register and have the four function pointers set to the same  
function.

Is this the right usage model, or should I set the mode register as  
part of the txrx_word[mode] function?

- kumar
