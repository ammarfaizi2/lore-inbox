Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281415AbRKEXAW>; Mon, 5 Nov 2001 18:00:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281416AbRKEXAI>; Mon, 5 Nov 2001 18:00:08 -0500
Received: from codepoet.org ([166.70.14.212]:32554 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S281415AbRKEW7z>;
	Mon, 5 Nov 2001 17:59:55 -0500
Date: Mon, 5 Nov 2001 15:59:56 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Tim Jansen <tim@tjansen.de>
Cc: Ben Greear <greearb@candelatech.com>, linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
Message-ID: <20011105155955.A16505@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Tim Jansen <tim@tjansen.de>, Ben Greear <greearb@candelatech.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0111051638230.27028-100000@duckman.distro.conectiva> <160qqc-1ClvWqC@fmrl04.sul.t-online.com> <3BE70B9A.1010904@candelatech.com> <160sXt-0LMrdQC@fmrl04.sul.t-online.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160sXt-0LMrdQC@fmrl04.sul.t-online.com>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 05, 2001 at 11:51:52PM +0100, Tim Jansen wrote:
> On Monday 05 November 2001 22:58, Ben Greear wrote:
> > So if BNF makes it harder for shell scripts and sscanf, and harder for
> > the kernel developers...what good does it do???  
> 
> You know how to parse the file. 
> Take a look at /proc/partitions. Is its exact syntax obvious without 
> examining the source in the kernel? Can it happen that there is a space or 
> another unusual character in the device path and what happens then? Could it 

Come now, it really isn't that difficult: 

    char name[80];
    unsigned long long size;
    unsigned int major, minor;
    
    if (sscanf(line, "%4u %4u %llu %s", &major, &minor, &size, name) == 4)
    {       
	add_partition(name, size, major, minor);
    }

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
