Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261400AbREQLn7>; Thu, 17 May 2001 07:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261401AbREQLnt>; Thu, 17 May 2001 07:43:49 -0400
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:54425 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261400AbREQLnh>; Thu, 17 May 2001 07:43:37 -0400
Date: Thu, 17 May 2001 13:43:35 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Scott Huang <SHuang@narus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CMPXCHG
Message-ID: <20010517134335.F754@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <580E532D9F7A9B4BAE8A130848E0DDA70B7842@franklin.narus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <580E532D9F7A9B4BAE8A130848E0DDA70B7842@franklin.narus.com>; from SHuang@narus.com on Wed, May 16, 2001 at 03:37:00PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2001 at 03:37:00PM -0700, Scott Huang wrote:
> Four adapters need to produce data to a 
> descriptor queue which is consumed by a
> user process. A lock mechanism was implemented
> to sync the adapters. However, this causes 
> a performance hit.  Is it possible to use
> CMPXCHG on Intel's i-386 to avoid the locking?

What about using atomic operations for that? This is more general
and works on ALL architectures. CMPXCHG is just and special
atomic operation on ia32.

> Where can I find some doc and some sample code?

   Documentation/DocBook/kernel-hacking.tmpl

But better do

   make htmldocs 

in the kernel top level directory and read

   Documentation/DocBook/kernel-hacking/lk-hacking-guide.html

instead.

Sample code is scattered all around in the kernel.


Regards

Ingo Oeser
-- 
To the systems programmer,
users and applications serve only to provide a test load.
