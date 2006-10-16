Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWJPCHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWJPCHQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 22:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932152AbWJPCHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 22:07:16 -0400
Received: from smtp101.sbc.mail.mud.yahoo.com ([68.142.198.200]:42905 "HELO
	smtp101.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751301AbWJPCHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 22:07:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=himqnKUKbp10wspDZr8AlCM4ZVSKWpZhfMJdHdBKHVsLCqYh7W0PsGpuDjETnAKO1J1RABc1GLFi9UKWX7+FPkzs8MMAVjZu/0g4SWWzEmDY2WBaLcJhi7JMxxDQvgJkGvfe+2xiOh4P+0AWdhAgG+R68IGHrNSxk94T0eWI2ik=  ;
From: David Brownell <david-b@pacbell.net>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/2] [PCI] Check that MWI bit really did get set
Date: Sun, 15 Oct 2006 19:07:08 -0700
User-Agent: KMail/1.7.1
Cc: Paul Mackerras <paulus@samba.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       matthew@wil.cx, val_henson@linux.intel.com, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       gregkh@suse.de
References: <1160161519800-git-send-email-matthew@wil.cx> <17714.54766.390707.532248@cargo.ozlabs.ibm.com> <20061015181044.ec414e4f.akpm@osdl.org>
In-Reply-To: <20061015181044.ec414e4f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610151907.09991.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 October 2006 6:10 pm, Andrew Morton wrote:

> - A printk if something went bad

Where "bad" would I hope exclude cases where the device
doesn't support MWI ... that is, the "go faster if you can"
advice from the driver, where it isn't an error to run into
the common case of _this_ implementation not happening to
be able to issue MWI cycles.

The other cases, where something actually went wrong, would
be reasonable for emitting KERN_ERR or KERN_WARNING messages.

- Dave

