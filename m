Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312681AbSFQMzy>; Mon, 17 Jun 2002 08:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312938AbSFQMzx>; Mon, 17 Jun 2002 08:55:53 -0400
Received: from mail1.infiniconsys.com ([65.219.193.230]:13988 "EHLO
	mail.infiniconsys.com") by vger.kernel.org with ESMTP
	id <S312681AbSFQMzw> convert rfc822-to-8bit; Mon, 17 Jun 2002 08:55:52 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: /proc/scsi/map
Date: Mon, 17 Jun 2002 08:55:48 -0400
Message-ID: <08628CA53C6CBA4ABAFB9E808A5214CB0C4D5D@mercury.infiniconsys.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: /proc/scsi/map
Thread-Index: AcIUpftiiGmXIK36TI24thg5YK4M+ABWD+MA
From: "Heinz, Michael" <mheinz@infiniconsys.com>
To: "Sancho Dauskardt" <sancho@dauskardt.de>, "Kurt Garloff" <garloff@suse.de>,
       "Linux kernel list" <linux-kernel@vger.kernel.org>,
       "Linux SCSI list" <linux-scsi@vger.kernel.org>
Cc: <linux-usb-devel@lists.sourceforge.net>,
       <linux1394-devel@lists.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From an infiniband point of view, this sounds great!

--
Michael Heinz
Infinicon Systems, Inc.
http://www.infiniconsys.com 

> -----Original Message-----
> From: Sancho Dauskardt [mailto:sancho@dauskardt.de]
> Sent: Saturday, June 15, 2002 3:50 PM
> To: Kurt Garloff; Linux kernel list; Linux SCSI list
> Cc: linux-usb-devel@lists.sourceforge.net;
> linux1394-devel@lists.sourceforge.net
> Subject: Re: /proc/scsi/map
> 
> 
> 
> >Life would be easier if the scsi subsystem would just report 
> which SCSI
> >device (uniquely identified by the 
> controller,bus,target,unit tuple) belongs
> >to which high-level device. The information is available in 
> the kernel.
> >
> >Attached patch does this:
> >garloff@pckurt:/raid5/Kernel/src $ cat /proc/scsi/map
> ># C,B,T,U       Type    onl     sg_nm   sg_dev  nm      dev(hex)
> >0,0,00,00       0x05    1       sg0     c:15:00 sr0     b:0b:00
> [...]
> 
> Great, this was really missing badly.
> 
> But how about adding another column: GUID.
> Most usb-storage and (all?) FireWire devices have such a 
> unique identitiy.
> In contrast to native SCSI devices, these emulated SCSI devices on 
> hot-plugging busses will change their LUNs/IDs. Therefor the 
> GUID is really 
> a must to be able to create stable names (laptop suspend, etc.).
> 
> Both usb-storage and iee1394-sbp2 know the GUID. It only needs to be 
> communicated..
> 
> I'd guess that FibreChannel has similar problems ?
> 
> - sda
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-scsi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
