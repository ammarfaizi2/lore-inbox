Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261579AbVDCH0x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261579AbVDCH0x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 03:26:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVDCH0x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 03:26:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50598 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261579AbVDCH0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 03:26:49 -0400
Message-ID: <424F9AA8.3020401@pobox.com>
Date: Sun, 03 Apr 2005 03:26:32 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jmerkey <jmerkey@utah-nac.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 Adaptec 4 Port Starfire Sickness
References: <424F73F8.8020108@utah-nac.org>
In-Reply-To: <424F73F8.8020108@utah-nac.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jmerkey wrote:
> With linux 2.6.9 running at 192 MB/S network loading and protocol 
> splitting drivers routing packets out of
> a 2.6.9 device at full 100 mb/s (12.5 MB/S) simultaneously over 4 ports, 
> the adaptec starfire driver goes into
> constant Tx FIFO reconfiguration mode and after 3-4 days of constantly 
> resetting the Tx FIFO window and
> generating a deluge of messages such as:
> 
> ethX:  PCI bus congestion, resetting Tx FIFO window to X bytes
> 
> pouring into the system log file at a rate of a dozen per minute.  After 
> several days, the PCI bus totally locks up
> and hangs the system.  Need a config option to allow the starfire to 
> disable this feature.  At very
> high bus loading rates, the starfire card will completely lock the bus 
> after 3-4 days
> of constant Tx FIFO reconfiguration at very high data rates with 
> protocol splitting and routing.

The feature doesn't need disabling; just modify the driver to stop the 
flapping.

	Jeff



