Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267162AbTBLPSr>; Wed, 12 Feb 2003 10:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267157AbTBLPSr>; Wed, 12 Feb 2003 10:18:47 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46354 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267145AbTBLPSq>;
	Wed, 12 Feb 2003 10:18:46 -0500
Message-ID: <3E4A6801.3050702@pobox.com>
Date: Wed, 12 Feb 2003 10:28:01 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Ballabio_Dario@emc.com
CC: manfred@colorfullife.com, warp@mercury.d2dc.net,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-eata@i-connect.net
Subject: Re: eata irq abuse (was: Re: Linux 2.5.60)
References: <70652A801D9E0C469C28A0F8BCF49CF9012EBA15@itmi1mx2.corp.emc.com>
In-Reply-To: <70652A801D9E0C469C28A0F8BCF49CF9012EBA15@itmi1mx2.corp.emc.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ballabio_Dario@emc.com wrote:
> Yes, you are correct. I used spin_unlock in order to release the local
> driver lock
> during the scsi_register call, but I forgot that I had the irq disabled as
> well.
> SO the correct fix is to use spin_unlock_irq/spin_lock_irq around the
> scsi_register call. Same fix applies to the u14-34f driver.


scsi_register may want to sleep, so that is not a fix at all...

