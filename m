Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313786AbSDZKTR>; Fri, 26 Apr 2002 06:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313791AbSDZKTQ>; Fri, 26 Apr 2002 06:19:16 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:4105 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id <S313786AbSDZKTQ>; Fri, 26 Apr 2002 06:19:16 -0400
Date: Fri, 26 Apr 2002 14:18:58 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Jurriaan on Alpha <thunder7@xs4all.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: compiling cmipci in 2.5.10 on Alpha doesn't work
Message-ID: <20020426141858.A20449@jurassic.park.msu.ru>
In-Reply-To: <20020426130514.A20345@jurassic.park.msu.ru> <Pine.LNX.4.33.0204261113230.487-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2002 at 11:17:23AM +0200, Jaroslav Kysela wrote:
> The real fix is to add '#include <linux/pci.h>' line to all necessary 
> source files (sound/pci/cmipci.c in this example). Not all source files 
> need pci.h for compilation.

Yes, but quite a few of them. Almost all files under sound/pci,
plus isapnp stuff which needs struct pci_dev and struct pci_bus.
Including <linux/pci.h> in single place would be much simpler
and shouldn't break anything, no?

Ivan.
