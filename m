Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287868AbSAHLmN>; Tue, 8 Jan 2002 06:42:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287946AbSAHLmD>; Tue, 8 Jan 2002 06:42:03 -0500
Received: from mxzilla4.xs4all.nl ([194.109.6.48]:29191 "EHLO
	mxzilla4.xs4all.nl") by vger.kernel.org with ESMTP
	id <S287868AbSAHLlx>; Tue, 8 Jan 2002 06:41:53 -0500
Date: Tue, 8 Jan 2002 12:41:51 +0100
From: jtv <jtv@xs4all.nl>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Tim Hollebeek <tim@hollebeek.com>,
        Bernard Dautrevaux <Dautrevaux@microprocess.com>,
        "'dewar@gnat.com'" <dewar@gnat.com>, paulus@samba.org, gcc@gcc.gnu.org,
        linux-kernel@vger.kernel.org, trini@kernel.crashing.org,
        velco@fadata.bg
Subject: Re: [PATCH] C undefined behavior fix
Message-ID: <20020108124151.E11855@xs4all.nl>
In-Reply-To: <17B78BDF120BD411B70100500422FC6309E402@IIS000> <20020107224907.D8157@xs4all.nl> <20020107172832.A1728@cj44686-b.reston1.va.home.com> <20020107231620.H8157@xs4all.nl> <20020108012734.E23665@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020108012734.E23665@werewolf.able.es>; from jamagallon@able.es on Tue, Jan 08, 2002 at 01:27:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 01:27:34AM +0100, J.A. Magallon wrote:
> >
> >	int a = 3;
> >	{
> >		volatile int b = 10;
> 
>     >>>>>>>>> here b changes

Yes, thank you, that part was obvious already.  The question pertained
to the fact that nobody outside compiler-visible code was being handed
an address for b, and so the compiler could (if it wanted to) prove
under pretty broad assumptions that nobody could *find* b to make the
change in the first place.

Now other people assure me that the Standard explicitly rules this out,
and I'm willing to believe that--although naturally I'd still feel more 
comfortable if I'd actually seen the relevant text.  Just so long as
we're not making another wild-guess stab at solving the problem.


Jeroen

