Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271265AbRIDOBs>; Tue, 4 Sep 2001 10:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271878AbRIDOBj>; Tue, 4 Sep 2001 10:01:39 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:56328 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S271265AbRIDOBY>; Tue, 4 Sep 2001 10:01:24 -0400
Message-ID: <3B94DEAF.B56E9742@loewe-komp.de>
Date: Tue, 04 Sep 2001 16:01:19 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: LOEWE. Hannover
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.9-ac3 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: "Elgar, Jeremy" <JElgar@ndsuk.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Applying multiple patches
In-Reply-To: <F128989C2E99D4119C110002A507409801555FD8@topper.hrow.ndsuk.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Elgar, Jeremy" wrote:
> 
> Hi,
> Sorry if this is covered somewhere but I had a look last night (and asked
> various people) but came up blank.
> 
> Is there a way to apply multiple patches to a source tree (if the patches
> were produced from the same base tree)
> 
> The problem I have is thus,  I want to apply patch-2.4.9-ac6 (I guess might
> as well do ac7 now) and the xfs patch
> but both are from a vanilla 2-4-9.
> 
> Is there a standard way of doing this or is a `by hand solution`
> 
> (I managed to apply the ac first then the xfs (ignoring a couple of files
> that are older in ac) but it was the config file that was messed up)
> 
> Its probably quite simple but I couldn't figure it
> 
Apply them in any order (perhaps starting with the bigger one).
While patch runs, it prints out diagnostic messages.
If one reads "... Hunk failed ..." it generates files like
config.in 
config.in.rej
config.in.orig

Then you have to open config.in.rej look at the lines with "-" and "+"
in front and apply the patch manually to "config.in".

I would search with 

/usr/src/linux# find . -name "*.rej"
and apply the above procedure to every found file, deleting the .rej 
and .orig when done.
