Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275680AbRJNQFu>; Sun, 14 Oct 2001 12:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275709AbRJNQFl>; Sun, 14 Oct 2001 12:05:41 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:2944 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275680AbRJNQFb>;
	Sun, 14 Oct 2001 12:05:31 -0400
Date: Sun, 14 Oct 2001 12:06:02 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
cc: linux-kernel@vger.kernel.org
Subject: Re: mount --bind and -o [re: nosuid/noexec/nodev handling]
In-Reply-To: <20011014185908.P1074@niksula.cs.hut.fi>
Message-ID: <Pine.GSO.4.21.0110141201540.6026-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 14 Oct 2001, Ville Herva wrote:

> Ummh, is there a reason for this behaviour?
> 
> $ mount --bind -o noexec /bin /home/sftp/bin

Broken - mount --bind ignores flags.  Create a binding, then remount it.
IOW, two mount(2) calls are needed.

