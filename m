Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbULJEBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbULJEBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 23:01:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbULJEBN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 23:01:13 -0500
Received: from relay.axxeo.de ([213.239.199.237]:17815 "EHLO relay.axxeo.de")
	by vger.kernel.org with ESMTP id S261673AbULJEBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 23:01:11 -0500
From: Ingo Oeser <ioe@axxeo.de>
Organization: Axxeo GmbH
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: Problem with ioctl command TCGETS
Date: Fri, 10 Dec 2004 05:01:04 +0100
User-Agent: KMail/1.6.2
References: <E1CYMI9-0005PL-00@calista.eckenfels.6bone.ka-ip.net> <E1CYOXh-0001nn-00@dorka.pomaz.szeredi.hu> <20041128130319.GB26051@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20041128130319.GB26051@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200412100501.04972.ioe@axxeo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You wrote:
[read/write vs ioctl]
> > Tell me how?  E.g. how would you set/get sound stream parameters if
> > not with ioctl()?
>
> Have several related files.

Look at your monitor. Technically this is an output device.
But there are little controls, where you can make adjustments.

ioctl is nothing else: A controller for an io-stream.

It also makes quite clear, that we are packetizing read/writes now.
And it cannot be fdopen()ed ;-)

Maybe we COULD split strictly for reads and writes, but
we still need a side channel for that to be opened by
passing a file descriptor.

How else would you control a tty/pty which you got as stdin/stdout?

Maybe one could hack this into xattr-support? ;-)

Regards

Ingo Oeser

