Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264784AbTFQPCA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 11:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264793AbTFQPCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 11:02:00 -0400
Received: from h24-206-178-254.sbm.shawcable.net ([24.206.178.254]:51608 "EHLO
	brianandsara.net") by vger.kernel.org with ESMTP id S264784AbTFQPB5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 11:01:57 -0400
From: Brian Jackson <brian@brianandsara.net>
Organization: brianandsara.net
To: Igor Krasnoselski <iek@tut.by>, linux-kernel@vger.kernel.org
Subject: Re: Can't mount an ext3 partition - why?
Date: Tue, 17 Jun 2003 10:16:05 -0500
User-Agent: KMail/1.5.2
References: <20030617132856.GC24306@www.13thfloor.at> <11725.030617@tut.by>
In-Reply-To: <11725.030617@tut.by>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306171016.05828.brian@brianandsara.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

devfs will do that, use devfsd to add those legacy device nodes to /dev.

--Brian

On Tuesday 17 June 2003 09:24 am, Igor Krasnoselski wrote:
> Hello Herbert,
>
> HP> what does an  fsck.ext3 -fpn  on the unmounted filesystem report?
>
> I downloaded 2.4.21 sources, made "make oldconfig" and got a new
> kernel with the same behavior :(
>
> fsck.ext3 (e2fsck 1.27 8-Mar-2002)
> run all 5 passes with no error reports under an old kernel, but under
> new one it says:
>
> fsck.ext3: No such file or directory while trying to open /dev/hdc1
>
> The superblock could not be read....
> etc.
>
> I get further into this, and I find that I have no /dev/hdc1 (and
> /dev/hdc, and /dev/hda too) at all! In place of them(?), I have
>
> /dev/discs/~disc0/disc
> /dev/discs/~disc0/part1
> /dev/discs/~disc0/part2
> /dev/discs/~disc0/part3
> /dev/discs/~disc1/disc
> /dev/discs/~disc1/part1
>
> e2fsck gets them as previous /dev/hd+ args and reports no errors.
> Is this a new feature since 2.4.18-3 kernel? Or maybe this all because
> I add something strange to my config, like "/dev filesystem" ?

-- 
OpenGFS -- http://opengfs.sourceforge.net
Home -- http://www.brianandsara.net

