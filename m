Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932159AbWC1Ntx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932159AbWC1Ntx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 08:49:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932213AbWC1Ntx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 08:49:53 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:51717 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932159AbWC1Ntw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 08:49:52 -0500
Date: Tue, 28 Mar 2006 15:49:47 +0200
From: Christian Cachin <cca@zurich.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: eCryptfs Design Document
Message-ID: <20060328154947.2e2ae43b@localhost.localdomain>
Organization: IBM Zurich Research Lab
X-Mailer: Sylpheed-Claws 2.0.0 (GTK+ 2.8.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm a cryptographer with an interest in encrypting stored data.

Mike had asked me to read the eCryptfs design and I can confirm the
security statements made there, and that the algorithm choices are
adequate.  The current release does not support integrity protection, but
this feature is promised for the next release through a MAC. 

I don't see the need for tweakable encryption modes (like LRW, CMC)
in the eCryptfs strategy because being a virtual file system, it can
afford to insert some extra space and is not bound to the block
boundaries like a block device, for which these were developed.  And with
integrity protection coming in the next release, the little extra security
gained in the current release by the tweakable modes would be a wasted
effort.

cc

--- 
Christian Cachin                           email: cca@zurich.ibm.com
IBM Zurich Research Laboratory                  tel: +41-44-724-8989
Saumerstrasse 4 / Postfach                      fax: +41-44-724-8953
CH-8803 Rueschlikon, Switzerland      http://www.zurich.ibm.com/~cca

