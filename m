Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270287AbTGMQn3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 12:43:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270283AbTGMQn3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 12:43:29 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16052 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S270281AbTGMQn1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 12:43:27 -0400
Message-ID: <3F118F99.1020104@pobox.com>
Date: Sun, 13 Jul 2003 12:58:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Roland Dreier <roland@topspin.com>, "David S. Miller" <davem@redhat.com>,
       Alan Shih <alan@storlinksemi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: TCP IP Offloading Interface
References: <ODEIIOAOPGGCDIKEOPILCEMBCMAA.alan@storlinksemi.com>	 <20030713004818.4f1895be.davem@redhat.com>  <52u19qwg53.fsf@topspin.com> <1058113895.554.7.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1058113895.554.7.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Finally if you are streaming objects by non mapped references (eg
> sendfile or see LM's paper from long ago on splice()) then the problem
> goes away.


As an aside, I really like sendfile's semantics except for

* People occasionally want to add a receivefile(2).  I disagree... 
sendfile(2) interface should be really be considered a universal 
"fdcopy" interface, regardless of what the 'to' and 'from' file 
descriptors are attached to.  File to socket.  Socket to file.  File to 
file.  socket to socket.  All should be supported, even if the fallback 
is a stupid (but small!) in-kernel copy loop.

* Copy-until-EOF semantics are either undefined, or, unclear to me 
personally.

	Jeff



