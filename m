Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313319AbSDYS7v>; Thu, 25 Apr 2002 14:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313325AbSDYS7u>; Thu, 25 Apr 2002 14:59:50 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:45818 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S313319AbSDYS7u>;
	Thu, 25 Apr 2002 14:59:50 -0400
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15560.20999.615343.77064@napali.hpl.hp.com>
Date: Thu, 25 Apr 2002 11:59:19 -0700
To: Christopher Yeoh <cyeoh@samba.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, anton@samba.org, paulus@samba.org
Subject: Re: [PATCH] SIGURG incorrectly delivered to process
In-Reply-To: <15550.24352.446276.774799@gargle.gargle.HOWL>
X-Mailer: VM 7.03 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Thu, 18 Apr 2002 15:52:32 +1000, Christopher Yeoh <cyeoh@samba.org> said:

  Christopher> If a process is sent a SIGURG signal and it is blocking
  Christopher> SIGURG signals, when the process subsequently unblocks
  Christopher> SIGURG signals it will be terminated even if it is set
  Christopher> to the default action (SIG_DFL) which is specified by
  Christopher> SUSv3 to ignore that signal.

Looks like a correct fix to me.  I made this change to the ia64 tree.

Thanks,

	--david
