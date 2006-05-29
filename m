Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751254AbWE2UrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751254AbWE2UrO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 16:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbWE2UrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 16:47:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:58676 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751254AbWE2UrO convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 16:47:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZNDuLQYhkoEg7JDEEu/kR2JUC5bWtBBKFmaB9/Zm313ttSCNjM8pqvtv84Pfu1/48WdHlEzoZgXlfQj8NI2D6jixsGKM5BQSsMBS5yOwyLF9uB/O4TWfgmqFbuAtbF3KP6lrZiUWiYZZabf9kESAQXo2BC3QdbEEUarcXknd1mI=
Message-ID: <bda6d13a0605291347t71311c6g95ebf53aa2ac392f@mail.gmail.com>
Date: Mon, 29 May 2006 13:47:11 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add compile domain (was: Re: [PATCH] Well, Linus seems to like Lordi...)
In-Reply-To: <Pine.LNX.4.64.0605291318420.5623@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060525141714.GA31604@skunkworks.cabal.ca>
	 <Pine.LNX.4.61.0605251829410.6951@yvahk01.tjqt.qr>
	 <Pine.LNX.4.64.0605250943520.5623@g5.osdl.org>
	 <20060529120821.GD22245@boogie.lpds.sztaki.hu>
	 <Pine.LNX.4.64.0605291318420.5623@g5.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, hostname --fqdn is so broken:

joshua@numenor:~$ hostname
numenor
joshua@numenor:~$ hostname --fqdn
numenor
joshua@numenor:~$

My normal take is not to use the FQDN as the hostname because it
becomes too long.
If I ever need to know my outside-facing IP address, I connect a UDP
socket to 1.2.3.4
and to a getsockname(). To get outside-hostname, I do a reverse-lookup on that.
Since 1.0.0.0/8 will never be allocated, this is gauranteed to work
when there is a way out.
If there's no way out, I'll find that out too.
