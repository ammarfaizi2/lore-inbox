Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUFBM2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUFBM2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262422AbUFBM2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:28:20 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:37836 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262406AbUFBM2N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:28:13 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-22.tower-45.messagelabs.com!1086179291!3214271
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [141.156.156.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: How come dd if=/dev/zero of=/nfs/dev/null does not send packets over the network?
Date: Wed, 2 Jun 2004 08:27:44 -0400
Message-ID: <5D3C2276FD64424297729EB733ED1F76062436BE@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How come dd if=/dev/zero of=/nfs/dev/null does not send packets over the network?
Thread-Index: AcRInMprn8eIiyu3SFqKxuDRfTknugAABP8g
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       <linux-kernel@vger.kernel.org>, "Al Piszcz" <apiszcz@solarrain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I was thinking since /dev/null isn't a ``device'' like a hard drive is; I thought this would work but I now see why it doesn't, thanks.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Måns Rullgård
Sent: Wednesday, June 02, 2004 8:20 AM
To: linux-kernel@vger.kernel.org
Subject: Re: How come dd if=/dev/zero of=/nfs/dev/null does not send packets over the network?

"Piszcz, Justin Michael" <justin.piszcz@mitretek.org> writes:

> root@jpiszcz:~# mkdir /p500/dev
> root@jpiszcz:~# mount 192.168.0.253:/dev /p500/dev
> root@jpiszcz:~# echo blah > /p500/dev/null
> root@jpiszcz:~# ls -l /p500/dev/null
> crw-rw-rw-  1 root sys 1, 3 Jul 17  1994 /p500/dev/null
> root@jpiszcz:~# dd if=/dev/zero of=/p500/dev/null
>
> 6179737+0 records in
> 6179736+0 records out
>
> Instead it treats it as a local block device?
>
> Kernel 2.6.5.

That is how it's supposed to work.  Think about root on nfs.

-- 
Måns Rullgård
mru@kth.se

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


