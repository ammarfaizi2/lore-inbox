Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbUA3OLC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jan 2004 09:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbUA3OLC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jan 2004 09:11:02 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:26800 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261567AbUA3OLA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jan 2004 09:11:00 -0500
Subject: Re: Fw: [PATCH][2.6] PCI Scan all functions
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, greg@kroah.com, linux-kernel@vger.kernel.org,
       linuxppc64-dev@lists.linuxppc.org
In-Reply-To: <20040129153015.0e77f8e7.akpm@osdl.org>
References: <20040127130803.10b666f3.akpm@osdl.org>
	 <Pine.LNX.4.58.0401271345060.10794@home.osdl.org>
	 <1075241556.681.19.camel@magik>
	 <Pine.LNX.4.58.0401271428340.10794@home.osdl.org>
	 <1075247559.672.33.camel@magik>
	 <Pine.LNX.4.58.0401271559230.10794@home.osdl.org>
	 <1075417841.679.139.camel@magik>  <20040129153015.0e77f8e7.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1075471807.679.178.camel@magik>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 30 Jan 2004 08:10:08 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please send me a changelog description for this patch?  A bit of
> background for posterity, so other kernel developers can come in a year
> hence and answer the question "what's all this about then?".  Thanks.

Sure.  

On a ppc64 logically partitioned system, there can be a setup where
function 0 of a PCI-PCI bridge is assigned to one partition and
(for example) function 2 is assigned to a second partition.  On the
second partition, it would appear that function 0 does not exist, but
function 2 does.  If all the functions are not scanned, everything under
function 2 would not be detected.

This patch allows devices that don't respond to function 0, but do
respond to other functions to be marked with a quirk and have all of
their functions scanned.  

Thanks,
Jake

