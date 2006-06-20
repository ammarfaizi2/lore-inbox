Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030194AbWFTJPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030194AbWFTJPg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 05:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965086AbWFTJPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 05:15:35 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37035 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965085AbWFTJPf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 05:15:35 -0400
Date: Tue, 20 Jun 2006 02:15:18 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Johny =?UTF-8?B?w4Vnb3RuZXM=?= <johny@agotnes.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc5-mm3 - USB issues
Message-Id: <20060620021518.045c84fd.zaitcev@redhat.com>
In-Reply-To: <mailman.1149991921.17505.linux-kernel2news@redhat.com>
References: <mailman.1149991921.17505.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.2.3 (GTK+ 2.8.17; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 11 Jun 2006 12:06:00 +1000, Johny Ågotnes <johny@agotnes.com> wrote:

> My USB hub isn't recognised with the latest -mm series, whereas with 
> 2.6.16 vanilla it is picked up & used immediately.
> 
> The error I get in dmesg is;
> 
> hub 4-0:1.0: USB hub found
> hub 4-0:1.0: 2 ports detected
> usb 1-4: new high speed USB device using ehci_hcd and address 3
> ehci_hcd 0000:00:10.3: Unlink after no-IRQ?  Controller is probably 
> using the wrong IRQ.
> usb 1-4: device not accepting address 3, error -110

Compare the working dmesg and non-working dmesg. Likely, the interrupt
assignment was messed up.

-- Pete
