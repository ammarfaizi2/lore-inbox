Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267485AbUHJRoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267485AbUHJRoX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267534AbUHJRnc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:43:32 -0400
Received: from smtp1.bae.co.uk ([20.133.0.6]:54952 "EHLO smtp1.bae.co.uk")
	by vger.kernel.org with ESMTP id S267485AbUHJRhW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:37:22 -0400
Content-return: allowed
Date: Tue, 10 Aug 2004 18:45:04 +0100
From: "Luesley, William" <william.luesley@amsjv.com>
Subject: Network routing issue
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Message-id: <22CE8E75BE6AD3119A9800508B0FF7E9030BADD0@nmex02.nm.dsx.bae.co.uk>
MIME-version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-type: text/plain;	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have two devices setup as follows:


          A --------------- B
192.168.1.1                 192.168.1.2


The machines open a number of TCP and UDP ports with which to communicate.
In order to help testing, I have been asked to place a third machine between
these two which will be capable of intercepting and modifying any messages.
My initial plan was to have a device which could mimic both ends of the
connection (as I already have code to do this); with each connection being
on a separate NIC, leading to a setup as shown below:

          A ------------ C  C  ---------- B
192.168.1.1    192.168.1.2  192.168.1.1   192.168.1.2
                    (eth0)  (eth1)

The obvious problem with this is that as C implements both ends of the
interface, any messages it sends are routed internally, rather than being
sent to the correct host.

I thought it would be possible to correct this by specifying the host routes
using the route command, i.e. setting a route to 192.168.1.1 via device eth0
and to 192.168.1.2 via eth1, therefore stopping the internal routing from
occurring. Even with these routes setup, the messages are still routed
internally.



Can the route somehow be forced?

If not, is there a way to stop the internal routing, preferably without a
code change to the kernel (if it is a code change - can someone point me
towards the file)?

Can I use IP Tables, how?

Or, am I on totally the wrong track?


Thanks for peoples time spent reading and looking into this.







********************************************************************
This email and any attachments are confidential to the intended
recipient and may also be privileged. If you are not the intended
recipient please delete it from your system and notify the sender.
You should not copy it or use it for any purpose nor disclose or
distribute its contents to any other person.
********************************************************************
