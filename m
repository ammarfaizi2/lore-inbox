Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTK0NeN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 08:34:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbTK0NeN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 08:34:13 -0500
Received: from oort.uva.nl ([146.50.97.204]:22356 "EHLO oort.uva.nl")
	by vger.kernel.org with ESMTP id S264496AbTK0NeL convert rfc822-to-8bit
	(ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 08:34:11 -0500
X-MIMEOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Bug in tun driver with devfs
Date: Thu, 27 Nov 2003 14:34:10 +0100
Message-ID: <05AB1317EF6EED4DBF540147C451596B4B7C66@oort.uva.nl>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Bug in tun driver with devfs
Thread-Index: AcO06yMlTx4xJOh0RBaNOP6uI0rFHQ==
From: "Hoogervorst, J.W." <J.W.Hoogervorst@uva.nl>
To: <Linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, list!

I found a bug with the tun device: when it auto-registers with devfs,
the softlink is set to "misc/net/tun", but the softlink itself is in
/dev/net, so this link points to /dev/net/misc/... which, ofcourse,
does not exist. This then results in a dead link.

Can anyone think of a clean fix for this?
(I haven't done any serious programming for some time and thus can
only think of some VERY dirty fixes atm)

Regards,
Jeroen
