Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932459AbWDZOr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932459AbWDZOr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 10:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbWDZOr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 10:47:29 -0400
Received: from fwstl1-1.wul.qc.ec.gc.ca ([205.211.132.24]:2261 "EHLO
	ecstlaurent8.quebec.int.ec.gc.ca") by vger.kernel.org with ESMTP
	id S932459AbWDZOr2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 10:47:28 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Subject: RE: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
Date: Wed, 26 Apr 2006 10:46:53 -0400
Message-ID: <8E8F647D7835334B985D069AE964A4F7011B260D@ECQCMTLMAIL1.quebec.int.ec.gc.ca>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2
Thread-Index: AcZpP6rpRW9i/MhBS86kKT3HHgZuTQAABGhg
From: "Fortier,Vincent [Montreal]" <Vincent.Fortier1@EC.GC.CA>
To: "Roger Heflin" <rheflin@atipa.com>
Cc: "Linux-Kernel" <linux-kernel@vger.kernel.org>, <linux-ide@vger.kernel.org>
X-OriginalArrivalTime: 26 Apr 2006 14:47:27.0684 (UTC) FILETIME=[56824840:01C66940]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is your OS installed either sda or sdb?

Because I get this type of message using a single disk... On which my FC5 stands...

I'll give it a try tonight and see if I can cause the problem manually but I doubt I'll be able to stop the system from hanging...  Unless my bug is not related.

- vin

-----Message d'origine-----
De : Roger Heflin [mailto:rheflin@atipa.com] 
Envoyé : 26 avril 2006 10:42
À : Fortier,Vincent [Montreal]
Cc : Linux-Kernel; linux-ide@vger.kernel.org
Objet : Re: Issues with sata_nv and 2 disks under 2.6.16 and 2.6.17-rc2

Fortier,Vincent [Montreal] wrote:
> I think I might be having the "same type of bug" or something related using sata_via?
> Bug opened at bugzilla: 
> http://bugzilla.kernel.org/show_bug.cgi?id=6317
> 
> This started appearing with 2.6.16.  It often does it using only one SATA HD.  It does not do it at every boot but often starts doing it after a little while (a few hours...) and finally hanging my PC.
> 
> - vin
> 
>

I can duplicate my problem everything, and I can make it stop a will.

doing "dd if=/dev/sda of=/dev/null bs=64k &"

and then

        "dd if=/dev/sdb of=/dev/null bs=64k &"

will cause the problem within a couple of seconds.

Doing "kill %1 %2" (assuming the dd's are %1 and %2) will stop the machine from hanging on disk io within 30-60 seconds.

Once it hangs it does not appear to do any disk io until the offending processes are killed.

                               Roger

