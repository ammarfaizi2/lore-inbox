Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264114AbTEJNmq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 09:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264116AbTEJNmq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 09:42:46 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:40597 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264114AbTEJNmp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 09:42:45 -0400
Message-Id: <200305101352.h4ADqoGi014392@locutus.cmf.nrl.navy.mil>
To: Christoph Hellwig <hch@infradead.org>
cc: Francois Romieu <romieu@fr.zoreil.com>,
       "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [UPDATE] unbalanced exit path in Forerunner HE he_init_one() (and an iphase patch too!) 
In-reply-to: Your message of "Sat, 10 May 2003 06:20:16 BST."
             <20030510062015.A21408@infradead.org> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sat, 10 May 2003 09:52:49 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030510062015.A21408@infradead.org>,Christoph Hellwig writes:
>> +init_one_failure:
>> +	if (atm_dev) atm_dev_deregister(atm_dev);
>> +	if (he_dev) kfree(he_dev);
>> +	pci_disable_device(pci_dev);
>> +	return err;
>
>kfree(NULL) if perfectly fine.  Also please untangle all this if
>statements to two separate lines.

but its ok for usb drivers?

class/usb-midi.c:       if ( u ) kfree(u);
class/usblp.c:          if (usblp->statusbuf) kfree(usblp->statusbuf);
class/usblp.c:          if (usblp->device_id_string) kfree(usblp->device_id_string);
image/mdc800.c:#define try_free_mem(A)  if (A != 0) { kfree (A); A=0; }
