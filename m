Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261874AbTJACG2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 22:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbTJACG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 22:06:28 -0400
Received: from quechua.inka.de ([193.197.184.2]:920 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261874AbTJACG0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 22:06:26 -0400
From: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linuxabi
Organization: Deban GNU/Linux Homesite
In-Reply-To: <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.1-20030907 ("Sandray") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E1A4WNJ-000182-00@calista.inka.de>
Date: Wed, 01 Oct 2003 04:05:57 +0200
X-Scanner: exiscan *1A4WNJ-000182-00*OPvRS8jY74.*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <UTC200310010001.h9101NU17078.aeb@smtp.cwi.nl> you wrote:
> +These headers are "append-only", in the sense that Linux
> +tries to keep supporting old interfaces.

I dont think this is true. Neighter was is true in the past nor is it
desireable in all cases. We may define a range of releases, where the ABI
will be stable, but I am not sure we find a text everybody agrees on.

I do think it is not a bead idea to keep deprecated values at least
commented out, to avoid reuse, whenever possible.

Otherwise I love the idea. Have you checked back with the Glibc folks?

> +#define MS_NODIRATIME  2048    /* Do not update directory access times */
> +#define MS_BIND                4096
> +#define MS_POSIXACL    (1<<16) /* VFS does not apply the umask */

can we clean that up? with shifting, without shifting, with comments and without comments? I suggest to use the linuxdoc comments mandatory for the abi files.

> + * Old magic mount flag and mask

i also suggest to think twice about using the word old somewhere.
valid-since, deprecated-after may be used in conjunction with version
identifiers. And not including deprecated symbols is also a good start.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
