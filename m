Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264558AbTLVXnh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 18:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264574AbTLVXng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 18:43:36 -0500
Received: from linux-bt.org ([217.160.111.169]:33201 "EHLO mail.holtmann.net")
	by vger.kernel.org with ESMTP id S264558AbTLVXnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 18:43:35 -0500
Subject: Re: [2.6 PATCH/RFC] Firmware loader - fix races and resource
	dealloocation problems
From: Marcel Holtmann <marcel@holtmann.org>
To: Greg KH <greg@kroah.com>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manuel Estrada Sainz <ranty@debian.org>,
       Patrick Mochel <mochel@osdl.org>
In-Reply-To: <20031222093759.GB30235@kroah.com>
References: <200312210137.41343.dtor_core@ameritech.net>
	 <20031222093759.GB30235@kroah.com>
Content-Type: text/plain
Message-Id: <1072136562.2876.32.camel@pegasus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 23 Dec 2003 00:42:42 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

> > It seems that implementation of the firmware loader is racy as it relies
> > on kobject hotplug handler. Unfortunately that handler runs too early,
> > before firmware class attributes controlling the loading process, are
> > created. This causes firmware loading fail at least half of the times on
> > my laptop.
> 
> Um, why not have your script wait until the files are present?  That
> will remove any race conditions you will have.

the firmware.agent script that is now in linux-hotplug already do a
"sleep 1" if the the loading file is not present.

Regards

Marcel


