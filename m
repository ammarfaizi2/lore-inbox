Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280938AbRLQPy6>; Mon, 17 Dec 2001 10:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280978AbRLQPyt>; Mon, 17 Dec 2001 10:54:49 -0500
Received: from aaf16.warszawa.sdi.tpnet.pl ([217.97.85.16]:52235 "EHLO
	aaf16.warszawa.sdi.tpnet.pl") by vger.kernel.org with ESMTP
	id <S280825AbRLQPyc>; Mon, 17 Dec 2001 10:54:32 -0500
Date: Mon, 17 Dec 2001 16:54:23 +0100
From: Dominik Mierzejewski <dominik@aaf16.warszawa.sdi.tpnet.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Why no -march=athlon?
Message-ID: <20011217155423.GA7123@wonko.esi.org.pl>
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x88r8ptki37.fsf@rpppc1.hns.com>
User-Agent: Mutt/1.3.24i
X-Linux-Registered-User: 134951
X-Homepage: http://home.elka.pw.edu.pl/~dmierzej/
X-PGP-Key-Fingerprint: B546 B96A 4258 02EF 5CAB  E867 3CDA 420F 7802 6AFE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 17 December 2001, nbecker@fred.net wrote:
> I noticed that linux/arch/i386/Makefile says:
> 
> ifdef CONFIG_MK7
> CFLAGS += -march=i686 -malign-functions=4 
> endif

Hm. As long as I can remember, 2.4 has always had this:
ifdef CONFIG_MK7
CFLAGS += $(shell if $(CC) -march=athlon -S -o /dev/null -xc /dev/null >/dev/null 2>&1; then echo "-march=athlon"; else echo "-march=i686 -malign-functions=4"; fi)
endif

Perhaps you're describing a 2.2 kernel?

-- 
"The Universe doesn't give you any points for doing things that are easy."
        -- Sheridan to Garibaldi in Babylon 5:"The Geometry of Shadows"
Dominik 'Rathann' Mierzejewski <rathann(at)we.are.one.pl>
