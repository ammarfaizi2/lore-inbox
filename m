Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269600AbUINTnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269600AbUINTnO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 15:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269439AbUINTm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 15:42:27 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:41384 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S269367AbUINTkd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 15:40:33 -0400
Message-ID: <41474926.8050808@nortelnetworks.com>
Date: Tue, 14 Sep 2004 13:40:22 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Giacomo A. Catenazzi" <cate@debian.org>
CC: linux-kernel@vger.kernel.org, greg@kroah.com,
       Tigran Aivazian <tigran@veritas.com>
Subject: Re: udev is too slow creating devices
References: <41473972.8010104@debian.org>
In-Reply-To: <41473972.8010104@debian.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giacomo A. Catenazzi wrote:

> udev + modular microcode:
> $ modprobe -r microcode
> $ modprobe microcode ; microcode_ctl -u
> => microcode_ctl does NOT find the device

The loading of the module triggers udev to run.  There is no guarantee that udev 
runs before microcode_ctl.

One workaround would be to have microcode_ctl use dnotify to get woken up 
whenever /dev changes.

There may be other ways to do this as well, but Greg would be the guy for that.

Chris
