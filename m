Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278151AbRJWSHp>; Tue, 23 Oct 2001 14:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278170AbRJWSHf>; Tue, 23 Oct 2001 14:07:35 -0400
Received: from femail4.sdc1.sfba.home.com ([24.0.95.84]:48616 "EHLO
	femail4.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S278151AbRJWSH1>; Tue, 23 Oct 2001 14:07:27 -0400
Date: Tue, 23 Oct 2001 13:07:56 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13-pre6 breaks Nvidia's kernel module
Message-ID: <20011023130756.A742@cy599856-a.home.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <200110221846.f9MIkE416013@riker.skynet.be> <3BD532EC.6080803@eisenstein.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BD532EC.6080803@eisenstein.dk>
User-Agent: Mutt/1.3.23i
X-Editor: GNU Emacs 20.7.2
X-Operating-System: Debian GNU/Linux 2.4.12-ac5 i586 K6-3+
X-Uptime: 13:02:21 up 0 min,  1 user,  load average: 0.57, 0.15, 0.05
From: Josh McKinney <forming@home.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Tue, Oct 23, 2001 at 11:05:48AM +0200, Jesper Juhl wrote:
> 
> I use the same version of the driver with my Geforce3 and I am also 
> running 2.4.13-pre6 and it works just fine so I don't agree with you 
> that it breaks...
> You do know that there are a few files that need to be recompiled every 
> time you build a new kernel - right?
> 

I have replied to this person personally a when this thread started with what I
think is the fix to his problem.  I have seen this error on my machine before.
The problem arose when I compiled the running kernel with gcc-3.0.  At first I
thought it was just gcc-3 breaking the kernel.  Then I realized that the nvidia
modules use `cc` to compile.  The symlink to cc was gcc-2.95.  Changing the
symlink to gcc-3.0 made the problem go away.

Josh
-- 
Linux, the choice                | The first Rotarian was the first man to
of a GNU generation       -o)    | call John the Baptist "Jack."   -- H.L.
Kernel 2.4.12-ac5          /\    | Mencken 
on a i586                 _\_v   | 
                                 | 
