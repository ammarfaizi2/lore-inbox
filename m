Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266686AbTAOQKY>; Wed, 15 Jan 2003 11:10:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266718AbTAOQKY>; Wed, 15 Jan 2003 11:10:24 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:52998 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266717AbTAOQKX>;
	Wed, 15 Jan 2003 11:10:23 -0500
Date: Wed, 15 Jan 2003 17:15:04 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Brice Goglin <bgoglin@ens-lyon.fr>
Cc: linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
Subject: Re: Dealing with 2.5.x subarch headers
Message-ID: <20030115161504.GA1133@mars.ravnborg.org>
Mail-Followup-To: Brice Goglin <bgoglin@ens-lyon.fr>,
	linux-kernel@vger.kernel.org, john stultz <johnstul@us.ibm.com>
References: <20030109163208.GG30490@ens-lyon.fr> <1042139980.1050.182.camel@w-jstultz2.beaverton.ibm.com> <20030115104814.GA4734@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030115104814.GA4734@ens-lyon.fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 15, 2003 at 11:48:14AM +0100, Brice Goglin wrote:
> Hi,
> 
> I am working on a module for 2.5.x. My module requires
> something like irq_vectors.h.
> Due do previous messages about this and John Stultz'
> subarch cleanup patch (merged in 2.5.53), I finally
> added "-Iinclude/asm/mach-default" to gcc options.

You should avoid introducing all this.
Do the following

$ make -C path/to/kernel/src SUBDIRS=$PWD modules

That will do the trick, and you include the .config for the selected kernel.

	Sam
