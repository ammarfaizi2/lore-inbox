Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314647AbSEFSLK>; Mon, 6 May 2002 14:11:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314649AbSEFSLJ>; Mon, 6 May 2002 14:11:09 -0400
Received: from AMontpellier-201-1-3-85.abo.wanadoo.fr ([193.252.1.85]:62654
	"EHLO awak") by vger.kernel.org with ESMTP id <S314647AbSEFSLI> convert rfc822-to-8bit;
	Mon, 6 May 2002 14:11:08 -0400
Subject: Re: _reliable_ way to get the dev for a mount point?
From: Xavier Bestel <xavier.bestel@free.fr>
To: andersen@codepoet.org
Cc: Pozsar Balazs <pozsy@sch.bme.hu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020506173857.GA24013@codepoet.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.3 
Date: 06 May 2002 20:10:30 +0200
Message-Id: <1020708630.17586.41.camel@bip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le lun 06/05/2002 à 19:38, Erik Andersen a écrit :
> On Mon May 06, 2002 at 11:55:38AM +0200, Pozsar Balazs wrote:
> > So, my question is there a way to get back the device for a directory,
> > _reliably_. (I want to know which devices holds the files my process sees
> > under an arbitrary /path/to/somewhere).
> 
> stat(mnt_point, &statbuf); then walk through /dev and stat each
> device, check that it is a block device and that st_rdev matches
> the statbuf.st_rdev.  When you get a match, you know a device
> name for the directory.

is devfs walkable ? I mean, no loops or infinite dynamically generated
directory ?


