Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287995AbSAHMhn>; Tue, 8 Jan 2002 07:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288001AbSAHMhd>; Tue, 8 Jan 2002 07:37:33 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:64774 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S287995AbSAHMhX>; Tue, 8 Jan 2002 07:37:23 -0500
To: jtv <jtv@xs4all.nl>
Cc: "J.A. Magallon" <jamagallon@able.es>, Tim Hollebeek <tim@hollebeek.com>,
        Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E402@IIS000>
	<20020107224907.D8157@xs4all.nl>
	<20020107172832.A1728@cj44686-b.reston1.va.home.com>
	<20020107231620.H8157@xs4all.nl>
	<20020108012734.E23665@werewolf.able.es>
	<20020108124151.E11855@xs4all.nl>
From: Alexandre Oliva <aoliva@redhat.com>
Organization: GCC Team, Red Hat
Date: 08 Jan 2002 10:36:47 -0200
In-Reply-To: jtv's message of "Tue, 8 Jan 2002 12:41:51 +0100"
Message-ID: <ory9j9uihs.fsf@free.redhat.lsd.ic.unicamp.br>
User-Agent: Gnus/5.0805 (Gnus v5.8.5) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan  8, 2002, jtv <jtv@xs4all.nl> wrote:

> On Tue, Jan 08, 2002 at 01:27:34AM +0100, J.A. Magallon wrote:
>> >
>> >	int a = 3;
>> >	{
>> >		volatile int b = 10;
>> 
>> >>>>>>>>> here b changes

> Yes, thank you, that part was obvious already.  The question pertained
> to the fact that nobody outside compiler-visible code was being handed
> an address for b, and so the compiler could (if it wanted to) prove
> under pretty broad assumptions that nobody could *find* b to make the
> change in the first place.

How about a debugger?

-- 
Alexandre Oliva   Enjoy Guarana', see http://www.ic.unicamp.br/~oliva/
Red Hat GCC Developer                  aoliva@{cygnus.com, redhat.com}
CS PhD student at IC-Unicamp        oliva@{lsd.ic.unicamp.br, gnu.org}
Free Software Evangelist    *Please* write to mailing lists, not to me
