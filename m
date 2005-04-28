Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262003AbVD1FUh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262003AbVD1FUh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 01:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262008AbVD1FUh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 01:20:37 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:25278 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262003AbVD1FUc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 01:20:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ItOi9Tn7W0KHvy38+iYQ8j531/1DzpDGennyv6Pu01CnP+wKaSUfchP7L+w6Izzj+e7pemnuuXJ45N0xf1Ja1F2FexjFs/BZaxXsT6XBCExg3CKFBPQUgKcO8suRKvtCdtJNQdjpUcFMu8QzSe2ydIgX8AeylQ7GIjMgZlzK1dQ=
Message-ID: <d4757e6005042722207e2b926@mail.gmail.com>
Date: Thu, 28 Apr 2005 01:20:32 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: Greg KH <greg@kroah.com>
Subject: Re: Device Node Issues with recent mm's and udev
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20050428050346.GB10182@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <d4757e6005042716523af66bae@mail.gmail.com>
	 <20050428041428.GB9723@kroah.com>
	 <d4757e6005042721577ba48cc@mail.gmail.com>
	 <20050428050346.GB10182@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/05, Greg KH <greg@kroah.com> wrote:
> On Thu, Apr 28, 2005 at 12:57:46AM -0400, Joe wrote:
> > It also seems to have trouble recreating the node even when the file
> > has been deleted
> 
> "trouble" how?
> 

Apparantly the other partitions of the device (ex. sdb1, sdb3) are
still considered nodes.  udev also seems to ignore them and hotplug
does not remove these nodes when the device is unplugged.

Additionally, when plugged back in, the device won't recreate the
nodes unless ALL of them are deleted, and even then its a hit and miss
as to whether it will decide to create them.
