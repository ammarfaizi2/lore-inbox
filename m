Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278152AbRJRVkd>; Thu, 18 Oct 2001 17:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278149AbRJRVkY>; Thu, 18 Oct 2001 17:40:24 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:37204 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S278136AbRJRVkH>; Thu, 18 Oct 2001 17:40:07 -0400
Date: Thu, 18 Oct 2001 17:40:39 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Petr Konecny <pekon@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel compilation problems - ld: bvmlinux
Message-ID: <20011018174039.N25384@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <qwwpu7kejz4.fsf@decibel.fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <qwwpu7kejz4.fsf@decibel.fi.muni.cz>; from pekon@informatics.muni.cz on Thu, Oct 18, 2001 at 11:06:39PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2001 at 11:06:39PM +0200, Petr Konecny wrote:
> Hi,
> 
> I am having trouble compiling 2.4.12 vanilla on i386 box, it ends with this:
> ld -m elf_i386 -Ttext 0x100000 -e startup_32 -o bvmlinux head.o misc.o piggy.o
> ld: bvmlinux: Not enough room for program headers (allocated 2, need 3)
> ld: final link failed: Bad value

Either add -z nocombreloc to ld's command line, or make sure you have
http://sources.redhat.com/ml/binutils/2001-10/msg00309.html
patch installed.

	Jakub
