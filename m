Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286386AbSAIN1q>; Wed, 9 Jan 2002 08:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286403AbSAIN1g>; Wed, 9 Jan 2002 08:27:36 -0500
Received: from 213-98-126-44.uc.nombres.ttd.es ([213.98.126.44]:16029 "HELO
	mitica.trasno.org") by vger.kernel.org with SMTP id <S286386AbSAIN1Y>;
	Wed, 9 Jan 2002 08:27:24 -0500
To: Felix von Leitner <felix-dietlibc@fefe.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
        andersen@codepoet.org
Subject: Re: [RFC] klibc requirements
In-Reply-To: <20020108192450.GA14734@kroah.com>
	<20020109042331.GB31644@codeblau.de>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <20020109042331.GB31644@codeblau.de>
Date: 09 Jan 2002 14:23:46 +0100
Message-ID: <m2elkzslnh.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "felix" == Felix von Leitner <felix-dietlibc@fefe.de> writes:

Hi

>> Comments from the various libc authors?  Comments from other kernel
>> developers about requirements and goals they would like to see from such
>> a libc?

felix> I think you need to ask initrd users.
felix> My understanding was that people want to use the IP autoconfiguration
felix> stuff from the kernel to initrd.  Is that still so?  What other programs
felix> are needed?

I can think of that in a fast thought:

- if fsck.* can be there, it will make fs nice, just now they have to
  be able to fsck a ro root fs.
- I suppose that you can put here also the raid autodetect code and
  things like that.
- you also need a very small minishell, something like nash (that
  cames with mkinitrd will suffice).
  Basic utility here is that you want to have several small programs
  and have a small shell script to configure them (a distribution
  dont' want to recompile all its boot programs for each target
  configuration).
- as I suppose that you have supposed insmod is essential :)
- you already put there IP autoconfiguration.

Later, Juan.



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
