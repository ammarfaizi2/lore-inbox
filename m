Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274813AbRKMPhc>; Tue, 13 Nov 2001 10:37:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273305AbRKMPhV>; Tue, 13 Nov 2001 10:37:21 -0500
Received: from mamona.cetuc.puc-rio.br ([139.82.74.4]:28579 "EHLO
	mamona.cetuc.puc-rio.br") by vger.kernel.org with ESMTP
	id <S273213AbRKMPhO>; Tue, 13 Nov 2001 10:37:14 -0500
Message-ID: <1353.139.82.28.36.1005665947.squirrel@mamona.cetuc.puc-rio.br>
Date: Tue, 13 Nov 2001 13:39:07 -0200 (BRST)
Subject: Re: /proc/<pidnumber>/stat hangs reading process
From: "Marcelo Roberto Jimenez" <mroberto@cetuc.puc-rio.br>
To: linux-kernel@vger.kernel.org, myrjola@lut.fi
X-Mailer: SquirrelMail (version 1.0.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mika,

> Hello,
> basically this posting is about the same problem as one I posted in 
> September:
> 
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0109.0/0764.html
> 
> It's essentially the same situation: I was running mozilla and it stopped
> responding to any input. I tried to kill it with control-c, kill and
> finally with kill -9, but none helped. When I tried to look at the output
> of top and ps, the exactly same symptons appeared; those processes didn't
> finish and can't be killed either. When I do strace ps the output ends 
> at:
> 
> stat64("/proc/16515", {st_mode=S_IFDIR|0555, st_size=0, ...}) = 0
> open("/proc/16515/stat", O_RDONLY)      = 7
> read(7,

I'm having this problem too, for a long time. It's usually associated with big loads ( for my machine, of course, a PII-233 ). It has happened while opening lot's of pages with opera, but has also happened while compiling 3 kernels at the same time and playing a video with xine or aviplay.

The behavior is the same: ps blocks, gtop blocks, killall blocks, anything that tries to get the process information blocks too.

The machine can be used as long as a program does not try to call the problematic function, whitch I wasn't able to trace down. 

I haven't had this problem for a while, basically because I try not to stress these ``hanging'' applications anymore, so that I can work, but I'll try to see if I can reproduce the bug with the new VM.

The problem is: what can we do, to investigate the problem, once ps starts to block? 

Regards,

Marcelo.


