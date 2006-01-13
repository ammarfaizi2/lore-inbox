Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422832AbWAMTIQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422832AbWAMTIQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422833AbWAMTIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:08:15 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.7]:47632 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1422832AbWAMTIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:08:14 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Duncan Sands <duncan.sands@free.fr>
Subject: Re: speedtch driver, 2.6.14.2
Date: Fri, 13 Jan 2006 19:08:16 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <200511232125.25254.s0348365@sms.ed.ac.uk> <200601131315.55355.duncan.sands@free.fr>
In-Reply-To: <200601131315.55355.duncan.sands@free.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131908.16584.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 12:15, Duncan Sands wrote:
> > I recently switched from the userspace speedtouch driver to the in-kernel
> > one. However, on my rev 4.0 Speedtouch 330, I periodically get the
> > message:
> >
> > ATM dev 0: error -110 fetching device status
>
> Is this correlated with disk activity (heavy use of the pci bus)?

No, the machine is completely idle. However I switched to the CVS driver (it 
does not work in isochronous mode still), and in bulk-mode it gives me a new 
set of messages:

ATM dev 0: speedtch_read_status: MSG E failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG F failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG F failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG D failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG D failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG D failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG B failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG B failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG B failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG F failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG F failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG B failed
ATM dev 0: error -110 fetching device status
ATM dev 0: speedtch_read_status: MSG F failed
ATM dev 0: error -110 fetching device status

This seems to happen less often than with the kernel driver, however.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
