Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130442AbRCGIa0>; Wed, 7 Mar 2001 03:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130443AbRCGIaQ>; Wed, 7 Mar 2001 03:30:16 -0500
Received: from office.globe.cz ([212.27.204.26]:50448 "HELO gw.office.globe.cz")
	by vger.kernel.org with SMTP id <S130442AbRCGIaJ>;
	Wed, 7 Mar 2001 03:30:09 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: binfmt_script and ^M
In-Reply-To: <3AA4D92D.CDDB764D@ftel.co.uk>
	<JKEGJJAJPOLNIFPAEDHLEEDGCJAA.laramie.leavitt@btinternet.com>
	<20010306151242.D31649@dev.sportingbet.com>
From: Ondrej Sury <sury.ondrej@globe.cz>
Date: 07 Mar 2001 09:29:22 +0100
In-Reply-To: <20010306151242.D31649@dev.sportingbet.com>
Message-ID: <87g0gq7zj1.fsf@druid.office.globe.cz>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.0.98
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Hunter <sean@dev.sportingbet.com> writes:

> I propose
> /proc/sys/kernel/im_too_lame_to_learn_how_to_use_the_most_basic_of_unix_tools_so_i_want_the_kernel_to_be_filled_with_crap_to_disguise_my_ineptitude

Well, too me it seems that you are intolerant.


I think that it should not be added to kernel because:

#!/bin/sh
/usr/bin/perl^M

will write
--
: No such file or directory
--
(in real it writes '/usr/bin/perl<CR>: No such file or directory')

But what I do think is that more meaningful message should be printed to
output, because it is not only ^M issue.  You could mistype name of
interpreter and don't notice (/usr/bin/eprl or similar typos), and printing
message saying 'script.pl: file not found' is confusing.

I see problem somewhere else.  There are editors and viewers (for example
midnight commander) which will hide ^M from you, and left you totally
confused (that's why I am using emacs ;-), because you have no idea why it
doesn't work, because everything seems ok with this _broken_ behaviour.
This is really BAD thing.

And even more BAD thing is the intolerance shown in this thread.  People
are not morons just because they don't understand confusing message which
shell gives them.  Behaviour of kernel is good, error message is wrong.
What should be fixed is error message.

-- 
Ondøej Surý <ondrej@globe.cz>         Globe Internet s.r.o. http://globe.cz/
Tel: +420235365000   Fax: +420235365009         Plánièkova 1, 162 00 Praha 6
Mob: +420605204544   ICQ: 24944126             Mapa: http://globe.namape.cz/
GPG fingerprint:          CC91 8F02 8CDE 911A 933F  AE52 F4E6 6A7C C20D F273
