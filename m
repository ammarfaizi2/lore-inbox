Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266508AbUHIM0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266508AbUHIM0m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:26:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266522AbUHIM0l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:26:41 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:50140 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266508AbUHIMZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:25:31 -0400
Date: Mon, 9 Aug 2004 14:24:51 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091224.i79COp69009736@burner.fokus.fraunhofer.de>
To: eric@lammerts.org, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Eric Lammerts <eric@lammerts.org>

>On Fri, 6 Aug 2004, Joerg Schilling wrote:
>> The CAM interface (which is from the SCSI standards group)
>> usually is implemeted in a way that applications open /dev/cam and
>> later supply bus, target and lun in order to get connected
>> to any device on the system that talks SCSI.
>>
>> Let me repeat: If you believe that this is a bad idea, give very
>> good reasons.

>With this interface, how do you grant non-root users access to a CD
>writer, but prevent them from directly accessing a SCSI harddisk?

On Linux, it is impossible to run cdrecord without root privilleges.
Make cdrecord suid root, it has been audited....

On Solaris, there is ACLs, RBAC & getppriv() / setppriv()

http://docs.sun.com/db/doc/816-5167/6mbb2jaeu?a=expand

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
