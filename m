Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbUFBMIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbUFBMIK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 08:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUFBMF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 08:05:27 -0400
Received: from mail45.messagelabs.com ([140.174.2.179]:41376 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262170AbUFBMEi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 08:04:38 -0400
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-19.tower-45.messagelabs.com!1086177874!3263439
X-StarScan-Version: 5.2.10; banners=-,-,-
X-Originating-IP: [141.156.156.57]
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: How come dd if=/dev/zero of=/nfs/dev/null does not send packets over the network?
Date: Wed, 2 Jun 2004 08:04:06 -0400
Message-ID: <5D3C2276FD64424297729EB733ED1F7606243695@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How come dd if=/dev/zero of=/nfs/dev/null does not send packets over the network?
Thread-Index: AcRHqrqBVoyH3y57QLC2MRShybnlVAA7uNJQ
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: <linux-kernel@vger.kernel.org>
Cc: "Al Piszcz" <apiszcz@solarrain.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@jpiszcz:~# mkdir /p500/dev
root@jpiszcz:~# mount 192.168.0.253:/dev /p500/dev
root@jpiszcz:~# echo blah > /p500/dev/null
root@jpiszcz:~# ls -l /p500/dev/null
crw-rw-rw-  1 root sys 1, 3 Jul 17  1994 /p500/dev/null
root@jpiszcz:~# dd if=/dev/zero of=/p500/dev/null

6179737+0 records in
6179736+0 records out

Instead it treats it as a local block device?

Kernel 2.6.5.


