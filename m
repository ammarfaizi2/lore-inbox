Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932329AbWFNVJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932329AbWFNVJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 17:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932330AbWFNVJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 17:09:57 -0400
Received: from fmr17.intel.com ([134.134.136.16]:7640 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S932329AbWFNVJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 17:09:56 -0400
Message-ID: <44907B13.2030402@linux.intel.com>
Date: Wed, 14 Jun 2006 14:09:39 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Brice Goglin <brice@myri.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] PCI extended conf space when MMCONFIG disabled because
 of e820
References: <44907A8E.1080308@myri.com>
In-Reply-To: <44907A8E.1080308@myri.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brice Goglin wrote:er.
> 
> What would you think of a patch implementing the following strategy:
> 1) if MMCONFIG works, always use it (no change)
> 2) if MMCONFIG is disabled and we are accessing the regular config
> space, use direct conf (no change, should ensure that any machine will
> still boot fine)
> 3) if MMCONFIG is disabled but we are accessing the _extended_ config
> space, try mmconfig anyway since there's no other way to do it.

an OS isn't allowed to mix old and new access methods realistically so I don't think
this is a viable good solution...
