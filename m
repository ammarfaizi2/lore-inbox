Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287048AbSABWXo>; Wed, 2 Jan 2002 17:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287038AbSABWXi>; Wed, 2 Jan 2002 17:23:38 -0500
Received: from mxzilla4.xs4all.nl ([194.109.6.48]:51723 "EHLO
	mxzilla4.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287029AbSABWXX>; Wed, 2 Jan 2002 17:23:23 -0500
Date: Wed, 2 Jan 2002 23:23:21 +0100
From: jtv <jtv@xs4all.nl>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Richard Henderson <rth@redhat.com>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102232320.A19933@xs4all.nl>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 02, 2002 at 03:05:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 03:05:48PM -0700, Tom Rini wrote:
> 
> Well, the problem is that we aren't running where the compiler thinks we
> are yet.  So what would the right fix be for this?

Obviously -ffreestanding isn't, because this problem could crop up pretty
much anywhere.  The involvement of standard library functions is almost
coincidence and so -ffreestanding would only fix the current symptom.

I'm not much of a kernel hacker, but a quick (and not very efficient,
granted) fix could be to make the offset an extern variable, yes?  That
would force the compiler to fall back on the basic "your gun, your foot,
your choice" memory model.


Jeroen

