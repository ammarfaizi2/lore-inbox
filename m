Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWJMQr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWJMQr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 12:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWJMQr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 12:47:27 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:22712 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751375AbWJMQr0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 12:47:26 -0400
Subject: Re: [PATCH] HP mobile data protection system driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Burman Yan <yan_952@hotmail.com>,
       linux-kernel@vger.kernel.org, Andrey Panin <pazke@donpac.ru>
In-Reply-To: <20061013155020.GA8204@redhat.com>
References: <BAY20-F7ACD05600A29690DC3CCED80A0@phx.gbl>
	 <20061013092603.GA26306@pazke.donpac.ru>
	 <9a8748490610130306v3bfe13b4j135cc474ff718657@mail.gmail.com>
	 <20061013155020.GA8204@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 13 Oct 2006 18:13:41 +0100
Message-Id: <1160759621.25218.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-10-13 am 11:50 -0400, ysgrifennodd Dave Jones:
> Better yet, would be to use the same interface the hdaps driver uses
> so that userspace written for one accelerometer works with any hardware.
> Having to cope with a dozen different drivers who export in different
> places is just silly.

Agreed. We already have an interface layer for reporting multiple
dimensions of motion control - the joystick interface. I think we really
ought to use that with some way to spot that its HDAPS etc so drivers
can decide to use it for its intended purpose (eg a different device
name scheme). The joystick compatibility would also mean it can "just
work" if you tell games to use the device.

Alan
