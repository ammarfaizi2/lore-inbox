Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261590AbVDCHgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261590AbVDCHgj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 03:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261592AbVDCHgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 03:36:38 -0400
Received: from c-67-177-11-57.hsd1.ut.comcast.net ([67.177.11.57]:47744 "EHLO
	vger") by vger.kernel.org with ESMTP id S261590AbVDCHgd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 03:36:33 -0400
Message-ID: <424F9618.3000807@utah-nac.org>
Date: Sun, 03 Apr 2005 00:07:04 -0700
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.9 Adaptec 4 Port Starfire Sickness
References: <424F73F8.8020108@utah-nac.org> <424F9AA8.3020401@pobox.com>
In-Reply-To: <424F9AA8.3020401@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> jmerkey wrote:
>
>> With linux 2.6.9 running at 192 MB/S network loading and protocol 
>> splitting drivers routing packets out of
>> a 2.6.9 device at full 100 mb/s (12.5 MB/S) simultaneously over 4 
>> ports, the adaptec starfire driver goes into
>> constant Tx FIFO reconfiguration mode and after 3-4 days of 
>> constantly resetting the Tx FIFO window and
>> generating a deluge of messages such as:
>>
>> ethX: PCI bus congestion, resetting Tx FIFO window to X bytes
>>
>> pouring into the system log file at a rate of a dozen per minute. 
>> After several days, the PCI bus totally locks up
>> and hangs the system. Need a config option to allow the starfire to 
>> disable this feature. At very
>> high bus loading rates, the starfire card will completely lock the 
>> bus after 3-4 days
>> of constant Tx FIFO reconfiguration at very high data rates with 
>> protocol splitting and routing.
>
>
> The feature doesn't need disabling; just modify the driver to stop the 
> flapping.
>
> Jeff
>
>
>
>
I am going to try to just turn off the Tx FIFO setting in the code 
completely and see if this helps, not just
the message. See what happens ...

Jeff
