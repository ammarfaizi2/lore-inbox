Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751035AbWIMIzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbWIMIzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 04:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751036AbWIMIzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 04:55:37 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:3461 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1751034AbWIMIzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 04:55:37 -0400
Message-ID: <4507C685.2040101@s5r6.in-berlin.de>
Date: Wed, 13 Sep 2006 10:51:17 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: R: Linux kernel source archive vulnerable
References: <20060907182304.GA10686@danisch.de> <Pine.LNX.4.61.0609121619470.19976@chaos.analogic.com> <ee796o$vue$1@taverner.cs.berkeley.edu> <45073B2B.4090906@lsrfire.ath.cx> <ee7m7r$6qr$1@taverner.cs.berkeley.edu>
In-Reply-To: <ee7m7r$6qr$1@taverner.cs.berkeley.edu>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Wagner wrote:
>     (a) The Linux kernel tar archive contains files with world-writeable
>     permissions.

The group's and others' permissions in the tar archive don't matter.
They have no meaning on the local system. These archives are
distributions of sources and a few scripts --- they are not local archives.

>     (b) There is no need for those files to have world-writeable
>     permissions.  It doesn't serve any particular purpose.

Correction: The group's and others' permissions, regardless how they are
set in the tar archive, don't serve any particular purpose. You should
consequently demand that an archive format is used which does not
transfer group's and others' permissions at all.

>     (c) Some users may get screwed over by virtue of the fact that those
>     files are listed in the tar archive with world-writeable permissions.

Correction: Some users who set a wrong umask when creating files by
extraction from these archives and then attempt to build an own kernel
from that may screw themselves over.

The danger here as that users who handle umask in a wrong way actually
run self-made kernels. _This_ is what you should campaign against first.
-- 
Stefan Richter
-=====-=-==- =--= -==-=
http://arcgraph.de/sr/
