Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289072AbSAGBlf>; Sun, 6 Jan 2002 20:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289070AbSAGBlQ>; Sun, 6 Jan 2002 20:41:16 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:63439 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S289072AbSAGBlG>; Sun, 6 Jan 2002 20:41:06 -0500
To: Tom Rini <trini@kernel.crashing.org>
Cc: Jakub Jelinek <jakub@redhat.com>, Paul Mackerras <paulus@samba.org>,
        Gabriel Dos Reis <gdr@codesourcery.com>,
        mike stump <mrs@windriver.com>, dewar@gnat.com, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <200201061824.KAA19536@kankakee.wrs.com>
	<flg05jb4go.fsf@riz.cmla.ens-cachan.fr>
	<15416.51411.874019.838220@argo.ozlabs.ibm.com>
	<20020106231940.F531@sunsite.ms.mff.cuni.cz>
	<20020107000954.GO756@cpe-24-221-152-185.az.sprintbbd.net>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 06 Jan 2002 23:40:28 -0200
In-Reply-To: Tom Rini's message of "Sun, 6 Jan 2002 17:09:54 -0700"
Message-ID: <or3d1jey5v.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.0805 (Gnus v5.8.5) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan  6, 2002, Tom Rini <trini@kernel.crashing.org> wrote:

> On Sun, Jan 06, 2002 at 11:19:40PM +0100, Jakub Jelinek wrote:
>> On Mon, Jan 07, 2002 at 08:59:47AM +1100, Paul Mackerras wrote:

>> > 	asm("" : "=r" (x) : "0" (y));

>> Even if gcc learned to analyze asm statements (and use it in something other
>> than scheduling), I'm sure this wouldn't be optimized away exactly because
>> this construct is used by various projects exactly for this purpose (make
>> gcc think it can have any value allowed for the type in question).

> Yes, but there's no gaurentee of that.  It'd probably break a few things
> if they did, but there's nothing stopping them from doing it.

If we documented this side effect of such asm statements, one would
have to come up with a very strong case to change it.

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                  aoliva@{cygnus.com, redhat.com}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist    *Please* write to mailing lists, not to me
