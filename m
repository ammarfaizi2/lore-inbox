Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315480AbSFEPuX>; Wed, 5 Jun 2002 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315481AbSFEPuX>; Wed, 5 Jun 2002 11:50:23 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:1929 "HELO
	fresnel.labs.redhat.com") by vger.kernel.org with SMTP
	id <S315480AbSFEPuV>; Wed, 5 Jun 2002 11:50:21 -0400
To: Padraig Brady <padraig@antefacto.com>
Cc: andersen@codepoet.org,
        Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
        sopwith@redhat.com
Subject: Re: Need help tracing regular write activity in 5 s interval
In-Reply-To: <20020602135501.GA2548@merlin.emma.line.org>
	<3CFCA2B0.4060501@antefacto.com> <20020604120434.GA1386@codepoet.org>
	<3CFE1B78.9010406@antefacto.com>
From: Owen Taylor <otaylor@redhat.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20020605155017.251EC2423B5@fresnel.labs.redhat.com>
Date: Wed,  5 Jun 2002 11:50:17 -0400 (EDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Padraig Brady <padraig@antefacto.com> writes:

> I'm sure it will :-)
> 
> However this it just masking the "problem"

Well, the question is, "what is the problem"? 

Your problem is that a debug message is being output by the kernel and
filling your logs. If the debug message doesn't do anybody any good
(and it doesn't) then removing the debug message is a fine way of
solving the problem.

I looked at _why_ the debug message was being generated in this
particular case a long time ago, and it seemed to essentially be a bug
in the IDE code, but other than generating the debug message,
basically a harmless one, and there was no interest in fixing it among
the kernel people I talked to at the time.

(I don't remember details any more; it was several years ago.)

> , and I don't
> think it's "buggy CDROM drives" as I've tried 3 different
> machines with the following drives:
> 
> SAMSUNG DVD-ROM SD-612
> TOSHIBA DVD-ROM SD-C2402
> CREATIVE CD5233E
> 
> and they all show the same problem. I.E. logs filling with
> "VFS: Disk change detected on device ide1(22,0)".

*This* problem is certainly not a buggy CD-ROM. There are other
(rarer) problems with logs filling with magicdev that do have to do
with buggy CD-ROM drives; so that is perhaps what you heard about.

(Most common one is that some Yamaha CD-RW's apparently report media
in the drive when they don't have any media in the drive.  magicdev
tries to mount it, and that failure generates an error message.)

[...] 

> Also related, why does the LED flash on every ATA command?
> Is this controlled by the drive or ide controller?
> Are you telling me that windows would flash the LED every so often
> to automount CDs?

Are you sure that the LED flashing isn't the debug messages being
written to your hard drive?

Regards,
                                        Owen
