Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S135358AbQK0DAh>; Sun, 26 Nov 2000 22:00:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S135236AbQK0DA2>; Sun, 26 Nov 2000 22:00:28 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:785 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S135372AbQK0DAN>; Sun, 26 Nov 2000 22:00:13 -0500
Date: Sun, 26 Nov 2000 20:27:00 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, linux-kernel@vger.kernel.org
Subject: Re: initdata for modules?
Message-ID: <20001126202700.A2535@vger.timpanogas.org>
In-Reply-To: <20001126194943.F2265@vger.timpanogas.org> <3478.975290764@kao2.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <3478.975290764@kao2.melbourne.sgi.com>; from kaos@ocs.com.au on Mon, Nov 27, 2000 at 01:06:04PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2000 at 01:06:04PM +1100, Keith Owens wrote:
> On Sun, 26 Nov 2000 19:49:43 -0700, 
> "Jeff V. Merkey" <jmerkey@vger.timpanogas.org> wrote:
> >Microsoft drivers have an .INIT code section that is initialization 
> >ccode that get's chunked after it's loaded.  Their model allows 
> >memory segments to be defined as DISCARDABLE, which tells the loader
> >to chunk them after they get loaded in portable executable format.  
> 
> The loader is insmod, which does all its own reloaction and loading.
> The problem is that ancillary tools like ksymoops, gdb, kdb and
> possibly others do not expect sections to be discarded after load.
> Adding the feature to insmod is fairly easy, fixing the ancillary tools
> to understand that some sections are discarded after load is a bit
> harder.  Debugging is particularly messy, when an oops occurs how do we
> tell if the __init data been discarded yet or not?
> 
> I have added this to my investigation list for modutils, ksymoops and
> kdb 2.5, no promises.


:-)

Jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
