Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269271AbSIRTPU>; Wed, 18 Sep 2002 15:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269272AbSIRTPU>; Wed, 18 Sep 2002 15:15:20 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:34455 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S269271AbSIRTPQ>; Wed, 18 Sep 2002 15:15:16 -0400
Date: Wed, 18 Sep 2002 20:19:27 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Ulrich Drepper <drepper@redhat.com>
Cc: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Subject: Re: Hardware limits on numbers of threads?
Message-ID: <20020918201927.A27663@kushida.apsleyroad.org>
References: <3D88208E.8545AAA2@kegel.com> <3D882500.2000105@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D882500.2000105@redhat.com>; from drepper@redhat.com on Wed, Sep 18, 2002 at 12:02:24AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> > Is this true?  Where does the limit come from?
> 
> This was and is true with the kernel before 2.5.3<mumble> when Ingo 
> introduced TLS support since the thread specific data had to be 
> addressed via LDT entries and the LDT holds at most 8192 entries.  The 
> GDT based solution now implemented in the kernel has no such limitation 
> and the number of threads you can create with the new thread library is 
> only limited by system resources.

So you did not implement LDT entry swapping through the "segment not
present" traps?  Ah well, moot now :-)

-- Jamie
