Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288040AbSAMTkC>; Sun, 13 Jan 2002 14:40:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288050AbSAMTjm>; Sun, 13 Jan 2002 14:39:42 -0500
Received: from dsl081-053-223.sfo1.dsl.speakeasy.net ([64.81.53.223]:1152 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288040AbSAMTjh>;
	Sun, 13 Jan 2002 14:39:37 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
Date: Sun, 13 Jan 2002 20:43:20 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <a1oqmm$is3$1@cesium.transmeta.com>
In-Reply-To: <a1oqmm$is3$1@cesium.transmeta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16PqXQ-0000BD-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, the documentation is great and the approach seems fundamentallly 
sound.

On January 12, 2002 09:04 am, H. Peter Anvin wrote:
[...]
> 	PAD(n)	means padding with null bytes to an n-byte boundary
> 	[QUESTION: is the padding relative to the start of the
> 	previous header, or is it an absolute address?  Is it at all
> 	legal to have a header start on a non-multiple of 4?]

I'll vote for the always/absolute rule.

[...]
> The structure of the cpio_header is as follows (all 8-byte entries
> contain 32-bit hexadecimal ASCII numbers):

I thought there's a binary version of the cpio header.  What is the
point of the ascii encoding?

[...]
> The c_mode field matches the contents of st_mode returned by stat(2)
> on Linux, and encodes the file type and file permissions.
> 
> The c_filesize should be zero for any non-regular file.
> 
> If the filename is "TRAILER!!!" this is actually an end-of-file
> marker; the c_filesize for an end-of-file marker must be zero.

It sure looks ugly, but I suppose the c_filesize=zero is the real
end-of-file marker.  Did I mention it sure looks ugly?

--
Daniel
