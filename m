Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291621AbSBNNS3>; Thu, 14 Feb 2002 08:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291627AbSBNNST>; Thu, 14 Feb 2002 08:18:19 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:16853 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S291621AbSBNNSF>; Thu, 14 Feb 2002 08:18:05 -0500
Date: Thu, 14 Feb 2002 14:14:26 +0100 (CET)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-rc1
In-Reply-To: <Pine.LNX.4.21.0202131732330.20915-100000@freak.distro.conectiva>
Message-ID: <Pine.NEB.4.44.0202141404210.25879-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2002, Marcelo Tosatti wrote:

> So here it goes.
>
> rc1:
>...
> - Merge some -ac bugfixes			(Alan Cox)
>
> pre9:
>...
> - Add framebuffer support for trident graphics
>   card						(James Simmons)
>...

These two changes together result in the fact that there's now a
CONFIG_FB_TRIDENT but if you try to enable it compilation fails with a

  tridentfb.c:524: #error "Floating point maths. This needs fixing before
  the driver is safe"

which makes it pretty useless. Since this is a stable kernel series I want
to suggest that if there's no fix for this before 2.4.18-final to remove
the trident support from 2.4.18 and to re-add it in 2.4.19-pre1 (with
the hope that it will be fixed before 2.4.19-final).

cu
Adrian



