Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278748AbRJZQjL>; Fri, 26 Oct 2001 12:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278756AbRJZQjD>; Fri, 26 Oct 2001 12:39:03 -0400
Received: from 157-151.nwinfo.net ([216.187.157.151]:40111 "EHLO
	mail.morcant.org") by vger.kernel.org with ESMTP id <S278748AbRJZQiw>;
	Fri, 26 Oct 2001 12:38:52 -0400
Message-ID: <36895.24.255.76.12.1004114303.squirrel@webmail.morcant.org>
Date: Fri, 26 Oct 2001 09:38:23 -0700 (PDT)
Subject: Re: [livid-gatos] [RFC] alternative kernel multimedia API
From: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>
To: volodya@mindspring.com
In-Reply-To: <Pine.LNX.4.20.0110260757190.10883-100000@node2.localnet.net>
In-Reply-To: <Pine.LNX.4.20.0110260757190.10883-100000@node2.localnet.net>
Cc: xavier.bestel@free.fr, natedac@kscable.com, livid-gatos@linuxvideo.org,
        video4linux-list@redhat.com, linux-kernel@vger.kernel.org
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 
> On 26 Oct 2001, Xavier Bestel wrote:
> 
>> le ven 26-10-2001 à 01:14, volodya@mindspring.com a écrit :
>> 
>> > >  05,HUE=7\n
>> > >  07,some unrelated command
>> > > +05\n				# The HUE command was successful
>> > > :07,reply to unrelated command
>> > > :05,HUE=6\n			# Driver reported the HUE parameter as
>> 
>> I would prefer a proc-like interface to devices, e.g.:
>> 
>> /dev/video0/hue
>> /dev/video0/saturation
>> ...
>> 
>> more unix-like, no parsing involved.
> 
> This would be a problem as an application would need to open many files in order to
> operate such interface. Additionally, you underestimate the number of files needed.
> We'll need hue_range, hue_label, hue_comment and something else..
> 
> Parsing is not that hard I believe.
> 
>                         Vladimir Dergachev
> 
Might I suggest a single file interface then?
Say /dev/video0/config, which would hold

hue: 0
saturation: 0
brightness: 0
etc..

which one could open and read or write param: value to.
This, or with the linux wireless config tools, is how the airo module allows you to modify
card values and personally I like the simplicity of the approach. 

>> 
>> 	Xav
>> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in the body
>> of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html Please read the
>> FAQ at  http://www.tux.org/lkml/
>> 


-- 
Morgan Collins [Ax0n] http://sirmorcant.morcant.org
Software is something like a machine, and something like mathematics, and something like
language, and something like thought, and art, and information.... but software is not in
fact any of those other things.

