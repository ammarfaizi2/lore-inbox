Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132770AbRDDITj>; Wed, 4 Apr 2001 04:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132773AbRDDIT3>; Wed, 4 Apr 2001 04:19:29 -0400
Received: from se1.cogenit.fr ([195.68.53.173]:266 "EHLO se1.cogenit.fr")
	by vger.kernel.org with ESMTP id <S132771AbRDDITQ>;
	Wed, 4 Apr 2001 04:19:16 -0400
Date: Wed, 4 Apr 2001 10:18:11 +0200
From: Francois Romieu <romieu@cogenit.fr>
To: Krzysztof Halasa <khc@intrepid.pm.waw.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: configuring net interfaces
Message-ID: <20010404101811.A6803@se1.cogenit.fr>
In-Reply-To: <Pine.LNX.3.96.1010401165413.28121X-100000@mandrakesoft.mandrakesoft.com> <m31yrbce2m.fsf@intrepid.pm.waw.pl> <20010403102734.A27344@se1.cogenit.fr> <m3g0fq9loq.fsf@intrepid.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <m3g0fq9loq.fsf@intrepid.pm.waw.pl>; from khc@intrepid.pm.waw.pl on Tue, Apr 03, 2001 at 03:07:01PM +0200
X-Organisation: Marie's fan club - I
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa <khc@intrepid.pm.waw.pl> écrit :
[...]
> But it's still more complicated than the first one and I'm not sure 
> if doing that is worth it
> 
> > struc sub_req {
> > 	int sub_ioctl;
> 
> ... as we lose 4 bytes here (currently the union of structs in ifreq
> is limited to 16 bytes)

I missed that. Point taken.

[...]
> struct ifreq {
>         char name[16];
>         union {
>                 ...
>                 struct {
>                         int sub_command;
>                         int data_length;
>                         void *data;
>                 }
>         }ifru;
> }
> 
> ... while "data" would be fr_protocol, eth_physical etc.
> 
> It's (of course) more complicated, but there is a gain:
> - we can have different size requests (from 0 bytes to, say, 100KB)

Fine with me (some day we'll surely end passing those data via a read if we
need 300Mo but we're not there :o) ).

[Other points]

Yes.

-- 
Ueimor
