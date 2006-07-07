Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWGGMej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWGGMej (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 08:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWGGMei
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 08:34:38 -0400
Received: from spirit.analogic.com ([204.178.40.4]:6924 "EHLO
	spirit.analogic.com") by vger.kernel.org with ESMTP id S932147AbWGGMei convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 08:34:38 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
X-OriginalArrivalTime: 07 Jul 2006 12:34:36.0757 (UTC) FILETIME=[B5355850:01C6A1C1]
Content-class: urn:content-classes:message
Subject: Re: kernel thread priority
Date: Fri, 7 Jul 2006 08:34:31 -0400
Message-ID: <Pine.LNX.4.61.0607070831350.8870@chaos.analogic.com>
In-Reply-To: <Pine.GSO.4.64.0607071626210.2230@sunm21.sasken.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kernel thread priority
thread-index: AcahwbU/tLemjqOGT/Khou1C1Nx+hw==
References: <Pine.GSO.4.64.0607071626210.2230@sunm21.sasken.com>
From: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
To: "Subbu" <subbu@sasken.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>,
       <subbu2k_av@yahoo.com>
Reply-To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Jul 2006, Subbu wrote:

>
> Hi,
>
>     I have to run some part of my network driver code in a thread which
> should have highest priority.
>
>     I am working on 2.4.20-8 redhat 9 kernel version.
>
>     i am using kernel_thread function to run the current process in a
> thread.
>
>     How can i set the priority level of the same to the highest .
>
>     please help me in this regard. what are the functions i should use
> for this
>
>
>   Thanx in advance
>   subbu
>

Older kernels required something like:
 	task_lock(current);
 	current->nice = PRIORITY;
 	task_unlock(current);

Newer kernels use:

 	set_user_nice(current, PRIORITY);

>
>
> "SASKEN RATED Among THE Top 3 BEST COMPANIES TO WORK FOR IN INDIA - SURVEY 2005 conducted by the BUSINESS TODAY - Mercer - TNS India"
>
>                           SASKEN BUSINESS DISCLAIMER
> This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.16.4 on an i686 machine (5592.89 BogoMips).
New book: http://www.AbominableFirebug.com/
_


****************************************************************
The information transmitted in this message is confidential and may be privileged.  Any review, retransmission, dissemination, or other use of this information by persons or entities other than the intended recipient is prohibited.  If you are not the intended recipient, please notify Analogic Corporation immediately - by replying to this message or by sending an email to DeliveryErrors@analogic.com - and destroy all copies of this information, including any attachments, without reading or disclosing them.

Thank you.
