Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261557AbVFOUpT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVFOUpT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVFOUnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:43:47 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:6619 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261550AbVFOUmJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:42:09 -0400
Message-ID: <42B09298.4000600@austin.ibm.com>
Date: Wed, 15 Jun 2005 15:42:00 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
Reply-To: jschopp@austin.ibm.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russ Anderson <rja@sgi.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RCF] Linux memory error handling
References: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com>
In-Reply-To: <200506151430.j5FEUD7J1393603@clink.americas.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	A common question is whether single bit (corrected) errors will 
> 	turn into double bit (uncorrected) errors.  The answer is it
> 	depends on the underlying cause of the memory error.  There are
> 	some errors that show up as single bits, especially transient 
> 	and soft errors, that do not degrade over time.  There are other
> 	failures that do degrade over time.

This sounds like one of our primary motivations for working on memory 
hotplug remove.  Detection of recoverable errors that degrade to 
unrecoverable errors, but don't because we remove the memory before it 
gets that far.

Much PPC64 hardware/firmware already supports this detection.

