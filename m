Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265142AbTFYWuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 18:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265144AbTFYWuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 18:50:07 -0400
Received: from quechua.inka.de ([193.197.184.2]:33696 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S265142AbTFYWuE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 18:50:04 -0400
From: Bernd Eckenfels <ecki-lkm@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Undo aic7xxx changes (now rc7+aic20030603)
In-Reply-To: <20030625191655.GA15970@alpha.home.local>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.5.17-20030301 ("Bubbles") (UNIX) (Linux/2.4.20-xfs (i686))
Message-Id: <E19VJJ5-00040M-00@calista.inka.de>
Date: Thu, 26 Jun 2003 01:04:03 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030625191655.GA15970@alpha.home.local> you wrote:
> Hmmm no, you're right, I forgot about this case. I think that access time or
> other time-dependant informations may change often enough to make a big diff
> on checksums. I have no more idea at the moment. Or perhaps tar to a disk file
> instead of the tape and check that file :-/

you can cat the tree into md5sums or run md5sums on the tree:

find . -print0 | xargs -0 cat | md5sum

this will only compare file content. You could first dump it to a file and
then md5sum it, if you want to test also writes.

Greetings
Bernd
-- 
eckes privat - http://www.eckes.org/
Project Freefire - http://www.freefire.org/
