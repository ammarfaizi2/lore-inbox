Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313201AbSD3LEu>; Tue, 30 Apr 2002 07:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313206AbSD3LEt>; Tue, 30 Apr 2002 07:04:49 -0400
Received: from ns.suse.de ([213.95.15.193]:3601 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S313201AbSD3LEt>;
	Tue, 30 Apr 2002 07:04:49 -0400
Date: Tue, 30 Apr 2002 13:04:46 +0200
From: Dave Jones <davej@suse.de>
To: Lawrence Walton <lawrence@the-penguin.otak.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.9 and 1.5.10 don't boot
Message-ID: <20020430130445.B22842@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Lawrence Walton <lawrence@the-penguin.otak.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020429190248.GA3325@the-penguin.otak.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2002 at 12:02:48PM -0700, Lawrence Walton wrote:
 > unable to handle kernel null pointer deference at address 00000016
 > printing EIP:
 > c0198147
 > Oops:0000
 > CPU: 0
 > EIP: 0010:[<c0198147>] not tainted
 > EFLAGS: 00010213
 > EAX: 00000000 EBX: c17p4ac0 ECX: c17fec00 EDX: 00000088
 > ESI: 00000004 EDI: 00000008 EBX: c17f4ac0 ESP: c16e7dcc

This dump is useless to anyone, as the addresses need to be converted
to symbol names. The EIP being the more important one, followed by the
call trace.

If you don't want to have to type out a whole oops to feed to ksymoops,
you can look up the addresses in the System.map from that kernel.
Note, there are likely to be addresses that don't resolve. For example,
you may not find c0198147, but you will see c0198140 and c0198190. In
this circumstance, take the lower symbol.

Numeric only oopses are entirely useless.

    Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
