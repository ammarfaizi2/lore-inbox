Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265457AbTANWzi>; Tue, 14 Jan 2003 17:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265470AbTANWzi>; Tue, 14 Jan 2003 17:55:38 -0500
Received: from air-2.osdl.org ([65.172.181.6]:3202 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265457AbTANWzh>;
	Tue, 14 Jan 2003 17:55:37 -0500
Date: Tue, 14 Jan 2003 15:04:18 -0800
From: Bob Miller <rem@osdl.org>
To: DervishD <raul@pleyades.net>
Cc: Philippe Troin <phil@fifi.org>, root@chaos.analogic.com,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030114230418.GB4603@doc.pdx.osdl.net>
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <87iswrzdf1.fsf@ceramic.fifi.org> <20030114220401.GB241@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030114220401.GB241@DervishD>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2003 at 11:04:01PM +0100, DervishD wrote:
>     Hi Philippe :)
> 
> > You just overwrote all your arguments (argv[0] and others) and part of
> > the environment.
> 
>     Oh, sh*t, you're true, and that is the problem I was afraid to
> suffer from. Then, all I can do is overwrite argv[0] with a new
> string whose length is less or equal than the existing one.
> 
>     Well, I suppose I must go with that limitation.
> 
>     Thanks, Philippe, for the code snipped and the explanation.
> 
>     Raúl
> -

Or you can copy your all your args and env to a temporary place and
then re-build your args and env with the new argv[0] in it's place.
But you must be carefull that your new argv[0] length plus the 
length of all remaining args, envp and pointers is not greater than
the system defined size for this space.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
