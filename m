Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287995AbSACAOf>; Wed, 2 Jan 2002 19:14:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288055AbSACANH>; Wed, 2 Jan 2002 19:13:07 -0500
Received: from dot.cygnus.com ([205.180.230.224]:11531 "HELO dot.cygnus.com")
	by vger.kernel.org with SMTP id <S288039AbSACAIF>;
	Wed, 2 Jan 2002 19:08:05 -0500
Date: Wed, 2 Jan 2002 16:07:39 -0800
From: Richard Henderson <rth@redhat.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: jtv <jtv@xs4all.nl>, Momchil Velikov <velco@fadata.bg>,
        linux-kernel@vger.kernel.org, gcc@gcc.gnu.org,
        linuxppc-dev@lists.linuxppc.org,
        Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020102160739.A10659@redhat.com>
Mail-Followup-To: Richard Henderson <rth@redhat.com>,
	Tom Rini <trini@kernel.crashing.org>, jtv <jtv@xs4all.nl>,
	Momchil Velikov <velco@fadata.bg>, linux-kernel@vger.kernel.org,
	gcc@gcc.gnu.org, linuxppc-dev@lists.linuxppc.org,
	Franz Sirl <Franz.Sirl-kernel@lauterbach.com>,
	Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Corey Minyard <minyard@acm.org>
In-Reply-To: <87g05py8qq.fsf@fadata.bg> <20020102190910.GG1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102133632.C10362@redhat.com> <20020102220548.GL1803@cpe-24-221-152-185.az.sprintbbd.net> <20020102232320.A19933@xs4all.nl> <20020102231243.GO1803@cpe-24-221-152-185.az.sprintbbd.net> <20020103004514.B19933@xs4all.nl> <20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020103000118.GR1803@cpe-24-221-152-185.az.sprintbbd.net>; from trini@kernel.crashing.org on Wed, Jan 02, 2002 at 05:01:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 05:01:18PM -0700, Tom Rini wrote:
> Yes, but doesn't -ffreestanding imply that gcc _can't_ assume this is
> the standard library...

Ignore strcpy.  Yes, that's what visibly causing a failure here,
but the bug is in the funny pointer arithmetic.  Leave that in
there and the compiler _will_ bite your ass sooner or later.


r~
