Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314707AbSEHS7m>; Wed, 8 May 2002 14:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314769AbSEHS7l>; Wed, 8 May 2002 14:59:41 -0400
Received: from ns.suse.de ([213.95.15.193]:785 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314707AbSEHS7k>;
	Wed, 8 May 2002 14:59:40 -0400
Date: Wed, 8 May 2002 20:59:34 +0200
From: Dave Jones <davej@suse.de>
To: Erik Andersen <andersen@codepoet.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Padraig Brady <padraig@antefacto.com>,
        Anton Altaparmakov <aia21@cantab.net>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 56
Message-ID: <20020508205934.C23966@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Padraig Brady <padraig@antefacto.com>,
	Anton Altaparmakov <aia21@cantab.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3CD8DAA2.6080907@evision-ventures.com> <E175QP9-0001RO-00@the-village.bc.nu> <20020508182139.GA22659@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 08, 2002 at 12:21:39PM -0600, Erik Andersen wrote:
 >     if ((fd=open(device_string, O_RDONLY | O_NONBLOCK)) < 0) {
 ...

 > etc.... to detect the available ide devices without groveling
 > through /proc/ide?

This goes splat with removable IDE devices like ZIP drives etc.
They fail to open() unless you put a disk in them.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
