Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135247AbRAGCv5>; Sat, 6 Jan 2001 21:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135365AbRAGCvr>; Sat, 6 Jan 2001 21:51:47 -0500
Received: from hermes.mixx.net ([212.84.196.2]:58886 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S135640AbRAGCve>;
	Sat, 6 Jan 2001 21:51:34 -0500
Message-ID: <3A57D909.F6B9F8B0@innominate.de>
Date: Sun, 07 Jan 2001 03:48:41 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Hans-Joachim Baader <hjb@pro-linux.de>, Chris Mason <mason@suse.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.4.0-ac2
In-Reply-To: <20010107023111.DC3584D4220@grumbeer.hjb.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Joachim Baader wrote:
> I got an oops with 2.4.0-ac2. It said "Kernel Panic: Attempt to kill init"
> or similar. The oops didn't make it into the log but I photographed it
> and reconstructed it from the photos (USB digital cams are a great thing
> :-). After the oops, the machine was still responsive to SysRq and ping
> but nothing else.
> 
> I have Reiserfs latest version on one partition (/var).
> 
> Before the oops there were some APIC messages:
> APIC error on CPU0: 00(04)
> APIC error on CPU1: 08(08)
> and so on. Do they have anything to do with it?
> 
> Since I had high ISDN activity at this time, ISDN is a main suspect.

A null buffer was passed by kupdate_one_transaction (looks like a
Reiserfs function) to __refile_buffer.  Chris?

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
