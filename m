Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261401AbSJYNKt>; Fri, 25 Oct 2002 09:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261402AbSJYNKt>; Fri, 25 Oct 2002 09:10:49 -0400
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:51348 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S261401AbSJYNKs>;
	Fri, 25 Oct 2002 09:10:48 -0400
Date: Fri, 25 Oct 2002 14:18:24 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Jan Marek <linux@hazard.jcu.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [linux@hazard.jcu.cz: Re: [miniPATCH][RFC] Compilation fixes in the 2.5.44]
Message-ID: <20021025131824.GA1766@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Jan Marek <linux@hazard.jcu.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20021025112923.GB1073@hazard.jcu.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021025112923.GB1073@hazard.jcu.cz>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 01:29:23PM +0200, Jan Marek wrote:
 > > > 
 > > >         unsigned int status;
 > > > -       long esp;
 > > >  
 > > >         irq_enter();
 > > >  
 > > >  #ifdef CONFIG_DEBUG_STACKOVERFLOW
 > > >         /* Debugging check for stack overflow: is there less than 1KB free? */
 > > > +       long esp;
 > > > 
 > > > Most C compilers don't allow you to mix declarations and code.
 > > > This is allowed only in new C standards. But GCC 3 seems to cope,
 > > > so it's probably fine for new kernels.
 > > 
 > > This fragment must be fixed, look at Documentation/Changes:
 > gcc-2.95.4-17 on my Debian works fine on that and without any
 > messages... You can try it, if you have other version of compiler...

Try testing with CONFIG_DEBUG_STACKOVERFLOW=y

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
