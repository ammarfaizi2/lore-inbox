Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272578AbTHGAXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 20:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272379AbTHGAXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 20:23:31 -0400
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:58556 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S272578AbTHGAX3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 20:23:29 -0400
Message-ID: <3F319CD5.7060706@pacbell.net>
Date: Wed, 06 Aug 2003 17:27:01 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Daniel Blueman <daniel.blueman@gmx.net>
CC: linux-kernel@vger.kernel.org, greg@kroah.com,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [2.6.0-test2-bk5] OHCI USB printing causing
 system lockup...
References: <19853.1060209099@www44.gmx.net>
In-Reply-To: <19853.1060209099@www44.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Blueman wrote:
> When printing a test page on an Epson C62 through an unpowered USB 1.1 hub,
> the printer printed part of the page, then stopped.
> 
> The 'error -110' messages were being sent to the syslogs, and after pulling
> the connector to the USB hub, the system locked up.

So it seems like there are two errors:

  - timeouts during printing, reported recently on UHCI too;

  - the usb_buffer_free() oops from printer cleanup, likewise.

Seems more related to the printer driver than to OHCI ...

- Dave

