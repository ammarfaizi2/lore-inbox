Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268071AbRIRLqh>; Tue, 18 Sep 2001 07:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268145AbRIRLq1>; Tue, 18 Sep 2001 07:46:27 -0400
Received: from ns.suse.de ([213.95.15.193]:56079 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S268071AbRIRLqS> convert rfc822-to-8bit;
	Tue, 18 Sep 2001 07:46:18 -0400
To: Andi Kleen <ak@suse.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: Linux 2.4.10-pre11 -- __builtin_expect
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org.suse.lists.linux.kernel>
	<E15jBLy-0008UF-00@the-village.bc.nu.suse.lists.linux.kernel>
	<9o6j9l$461$1@cesium.transmeta.com.suse.lists.linux.kernel>
	<oup4rq0bwww.fsf_-_@pigdrop.muc.suse.de>
X-Yow: It don't mean a THING if you ain't got that SWING!!
From: Andreas Schwab <schwab@suse.de>
Date: 18 Sep 2001 13:13:48 +0200
In-Reply-To: <oup4rq0bwww.fsf_-_@pigdrop.muc.suse.de> (Andi Kleen's message of "18 Sep 2001 12:44:47 +0200")
Message-ID: <jeelp4rbtf.fsf@sykes.suse.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) Emacs/21.0.106
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

|> +#define likely(x)  __builtin_expect((x), !0) 

IMHO, this should better be written as

#define likely(x) __builtin_expect(!!(x), 1)

because x is not required to be pure boolean, so any nonzero value of x is
as likely as 1.

Andreas.

-- 
Andreas Schwab                                  "And now for something
Andreas.Schwab@suse.de				completely different."
SuSE Labs, SuSE GmbH, Schanzäckerstr. 10, D-90443 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
