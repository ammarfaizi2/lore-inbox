Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129398AbRAZCYt>; Thu, 25 Jan 2001 21:24:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbRAZCYj>; Thu, 25 Jan 2001 21:24:39 -0500
Received: from quattro.sventech.com ([205.252.248.110]:22797 "HELO
	quattro.sventech.com") by vger.kernel.org with SMTP
	id <S129398AbRAZCYY>; Thu, 25 Jan 2001 21:24:24 -0500
Date: Thu, 25 Jan 2001 21:24:20 -0500
From: Johannes Erdfelt <johannes@erdfelt.com>
To: "David S. Miller" <davem@redhat.com>
Cc: "H. Peter Anvin" <hpa@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
Message-ID: <20010125212419.G20628@sventech.com>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com> <94qcvm$9qp$1@cesium.transmeta.com> <14960.54069.369317.517425@pizda.ninka.net> <3A70D524.11362EFB@transmeta.com> <14960.54852.630103.360704@pizda.ninka.net> <3A70D7B2.F8C5F67C@transmeta.com> <14960.56461.296642.488513@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4i
In-Reply-To: <14960.56461.296642.488513@pizda.ninka.net>; from David S. Miller on Thu, Jan 25, 2001 at 06:10:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 25, 2001, David S. Miller <davem@redhat.com> wrote:
> 
> H. Peter Anvin writes:
>  > > RFC793, where is lists the unused flag bits as "reserved".
>  > > That is pretty clear to me.  It just has to say that
>  > > they are reserved, and that is what it does.
>  > > 
>  > 
>  > Is the definition of "reserved" defined anywhere?  In a lot of specs,
>  > "reserved" means MBZ.
>  > 
>  > Note, that I'm not arguing with you.  I'm trying to pick this apart.
> 
> It says "reserved for future use, must be zero".
> 
> I think the descrepency (and thus what the firewalls are doing) comes
> from the ambiguous "must be zero".  I cannot fathom the RFC authors
> meaning this to be anything other than "must be set to zero by current
> implementations" or else what is the purpose of the "reserved for
> future use part" right?
> 
> Honestly, is there anyone here who can tell me honestly that when they
> see the words "reserved" in the description of a bit field description
> (in a hardware programmers manual of some device, for example) that
> they think it's ok the read the value and interpret it in any way?
> 
> To me it's always meant "we want to do cool things in the future,
> things we haven't thought of now, so don't interpret these bits so we
> can do that and you will still work".

Generally it's to ensure that all implementations set those bit by
default to 0 as well.

Then in the future, 0 means "I don't support this feature either by
choice or by not implementing it yet".

JE

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
