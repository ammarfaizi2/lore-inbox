Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270992AbRIFOfx>; Thu, 6 Sep 2001 10:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270999AbRIFOfm>; Thu, 6 Sep 2001 10:35:42 -0400
Received: from va.flyingbuttmonkeys.com ([207.198.61.36]:26571 "EHLO
	va.flyingbuttmonkeys.com") by vger.kernel.org with ESMTP
	id <S270992AbRIFOfd>; Thu, 6 Sep 2001 10:35:33 -0400
Message-ID: <002b01c136e1$3bb36a80$81d4870a@cartman>
Reply-To: "Michael Rothwell" <rothwell@holly-springs.nc.us>
From: "Michael Rothwell" <rothwell@holly-springs.nc.us>
To: <linux-kernel@vger.kernel.org>
Subject: nfs is stupid ("getfh failed")
Date: Thu, 6 Sep 2001 10:35:53 -0400
Organization: Holly Springs, NC
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Two systems that worked fine for weeks, both running 2.4.[7,8] kernels. The
server is running 2.4.8 and exporting a reiserfs filesystem via nfs. Or it
was, anyway. The server was shut down and brought back up (power failure).
The client was then
rebooted.

server# cat /etc/exports
/export 192.168.1.*(rw,no_root_squash)
/export/home 192.168.1.*(rw,no_root_squash)

client# mount /export
mount: 192.168.1.1:/export failed, reason given by server: Permission denied

server# tail /var/log/messages
Sep  6 09:37:43 gateway rpc.mountd: authenticated mount request from
192.168.1.133:933 for /export (/export)
Sep  6 09:37:43 gateway rpc.mountd: getfh failed: Operation not permitted

... so,  rebooting two working systems seems to kill NFS. Any ideas why?

On a related topic, will Linux ever have a better file-service protocol?




