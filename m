Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbUJZOEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbUJZOEF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 10:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbUJZOEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 10:04:05 -0400
Received: from ms002msg.fastwebnet.it ([213.140.2.52]:51387 "EHLO
	ms002msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S262278AbUJZODo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 10:03:44 -0400
From: Alessandro Amici <lists@b-open-solutions.it>
Organization: B-Open Solutions srl
To: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Is anyone using the load_ramdisk= option in the kernel still?
Date: Tue, 26 Oct 2004 16:03:30 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <clkheo$otl$1@terminus.zytor.com>
In-Reply-To: <clkheo$otl$1@terminus.zytor.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410261603.30707.lists@b-open-solutions.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hpa,

On Tuesday 26 October 2004 05:48, H. Peter Anvin wrote:
> So, in short:
>
> a) Does anyone use the load_ramdisk= option anymore, or is it
> legitimate to drop?

I'm pretty sure it is used by the Debian installer when bootstrapping from a 
floppy, but...

> b) If it is necessary to retain, does anyone care if this option would
> only support gzip format in the future, i.e. NOT support uncompressed
> filesystem images?  Since a gzip stream is self-terminating, this
> takes care of the problem of finding the end, but adds a sizable chunk
> of code to the kinit binary.

... the image is read from a raw device (/dev/fd0) and it is gzipped.

Booting the installer is probably the only large scale use case for the 
load_ramdisk parameter.

Cheers,
Alessandro
