Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268704AbUIXMky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268704AbUIXMky (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 08:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268716AbUIXMky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 08:40:54 -0400
Received: from port-212-202-157-208.static.qsc.de ([212.202.157.208]:37029
	"EHLO zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S268704AbUIXMkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 08:40:51 -0400
Message-ID: <415415BD.4030007@ppp0.net>
Date: Fri, 24 Sep 2004 14:40:29 +0200
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
CC: linux-kernel@vger.kernel.org, Greg KH <greg@kroah.com>,
       Hotplug List <pcihpd-discuss@lists.sourceforge.net>
Subject: Re: Is there a user space pci rescan method?
References: <E8F8DBCB0468204E856114A2CD20741F2C13E2@mail.local.ActualitySystems.com> <4152FFA0.9020005@ppp0.net> <200409231905.47279@bilbo.math.uni-mannheim.de> <200409241241.19654@bilbo.math.uni-mannheim.de>
In-Reply-To: <200409241241.19654@bilbo.math.uni-mannheim.de>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rolf Eike Beer wrote:
> -changed param "usedonly" to "showunused" so it behaves like fakephp at the
>  first look: if you load dummyphp without parameters there are only slots with
>  devices in it.

Well, know I get only entries for all devices I don't have!

> + dslot->dev = pci_get_slot(dslot->bus, dslot->devfn);
> +
> + if (showunused || dslot->dev) {
> +  retval = 0;
> +  goto error_dslot;
> + }

This should probably be !showunused || !dslot->dev ?

Jan
