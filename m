Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130076AbQLETyg>; Tue, 5 Dec 2000 14:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129867AbQLETy1>; Tue, 5 Dec 2000 14:54:27 -0500
Received: from main.cyclades.com ([209.128.87.2]:46601 "EHLO cyclades.com")
	by vger.kernel.org with ESMTP id <S129410AbQLETyS>;
	Tue, 5 Dec 2000 14:54:18 -0500
Date: Tue, 5 Dec 2000 11:23:50 -0800 (PST)
From: Ivan Passos <lists@cyclades.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel List <linux-kernel@vger.kernel.org>, netdev@oss.sgi.com
Subject: Re: [RFC-2] Configuring Synchronous Interfaces in Linux
In-Reply-To: <E143Ebi-000500-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10012051118140.1713-100000@main.cyclades.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Dec 2000, Alan Cox wrote:
> 
> I think a new ioctl would be sensible. There is a lot to go in it. 

Alan, what's the approach you'd feel more comfortable with:
- One ioctl that passes a pointer to a known structure in ifr.ifr_data as 
  its argument.
- Several ioctl's, one for each parameter, that pass only the specific 
  parameter new value as the argument.

The former is good because it relies on a _single_ ioctl. However, every
time you change the ioctl structure you may lose backward compatibility.

The latter is good because new implementations / features won't affect
previous working features. However, it'd create a huge list of ioctl's.

Please let me know whatcha think.

Later,
Ivan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
