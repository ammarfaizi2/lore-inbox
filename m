Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268263AbUIBMBr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268263AbUIBMBr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:01:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUIBMBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:01:47 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:54244 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP id S268263AbUIBMBo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:01:44 -0400
From: Einar Lueck <elueck@de.ibm.com>
Reply-To: lkml@einar-lueck.de
Organization: IBM Deutschland Entwicklung GmbH
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
Date: Thu, 2 Sep 2004 14:01:42 +0200
User-Agent: KMail/1.6.2
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200409021401.42255.elueck@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-01 at 14:25, ?Alan Cox wrote:
> Is there anything here that cannot already be done by the ip route
> command and iptables nat ?
Our experiences with customers operating high-available enterprise
installations indicate that ip route and iptables nat do not fullfill all the 
relevant requirements:
The high-availability requirements drive those customers to ensure that 
all routes are dynamic which is not possible with the proposed ip route 
approach.
The complexity of the relevant setups necessitates an easy and 
requirements-driven configuration and solution approach. The overall 
concept of setting up a virtual device with a virtual IP adress and 
assigning this virtual IP adress as a Source VIPA to the devices which should
allow for a failover is well known from other operating system and expected 
by relevant enterprise customers.  IP routes and NAT allow to achieve the 
same effect with the exception mentioned above, but the corresponding 
configuration overhead is in the opinion of customers having enterprise 
setups too complex and complicated.  Our overall approach introduces 
this concept as a facility to address these requirements very clearly. 

Einar
