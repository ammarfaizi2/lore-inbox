Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTDJTss (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 15:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264132AbTDJTss (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 15:48:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:60578
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263953AbTDJTsr (for <rfc822;linux-kernel@vger.kernel.org>); Thu, 10 Apr 2003 15:48:47 -0400
Subject: Re: kernel support for non-english user messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Jim Keniston[UNIX]" <jkenisto@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E94AD48.B2E91CF9@us.ibm.com>
References: <3E94AD48.B2E91CF9@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050001294.12494.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 10 Apr 2003 20:01:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-04-10 at 00:31, Jim Keniston[UNIX] wrote:
> Kernel messages need to be logged in English.  By application of message
> catalogs or similar techniques, they can also be made available in other
> languages.  Translation to other languages should be done when the log
> is viewed.

Absolutely agreed. The only case you might want to argue otherwise is
panic and very early boot messages. and even then it is questionable.

> 	printk(KERN_INFO "link up, %d Mbps, %s-duplex\n", speed, duplex);
> you log the format string and the values of speed and duplex as separate
> attributes in the event log.  If/when you compute a hash, it's on the
> format string (and possibly on the function name and/or source-file
> name, to provide more context).

One of the problems is extracting the format string and other data. 

Making the log hold
<6>%s: carrier dropped and smashed on the floor[U001]eth0

is in itself not hard and a big step forward.

> - If we use 32-bit hash codes, there's a real chance of different
> messages

There are less than 65536 files each of which is less than 65536 lines
long, so it seems that a properly chosen automated index ought to be
collision free ?


