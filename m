Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbRAXIF1>; Wed, 24 Jan 2001 03:05:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129933AbRAXIFG>; Wed, 24 Jan 2001 03:05:06 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:36100
	"HELO metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S129846AbRAXIFE>; Wed, 24 Jan 2001 03:05:04 -0500
Date: Wed, 24 Jan 2001 21:05:00 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Leslie Donaldson <donaldlf@hermes.cs.rose-hulman.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question: Memory change request
Message-ID: <20010124210500.B7029@metastasis.f00f.org>
In-Reply-To: <3A6E79EA.C2AD3806@mailhost.cs.rose-hulman.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A6E79EA.C2AD3806@mailhost.cs.rose-hulman.edu>; from donaldlf@hermes.cs.rose-hulman.edu on Wed, Jan 24, 2001 at 12:44:58AM -0600
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 24, 2001 at 12:44:58AM -0600, Leslie Donaldson wrote:

    I need a block of memory that can notify me or even a flag set when
    it has been written to. I was thinking of letting the user code generate
    some sort of page fault... Any random thoughts would be greatly
    appreciated.
    
    mmm ... Basically dirty page logic for user space....

mprotect the page(s) you are interested in so you can't write to them
and catch SEGV -- when someone attempts to write you can pull apart
the stack frame mark the page(s) RO and continue.

if you are really stuck i think i have example code to do this
somewhere for ia32 (stack frame is arch. dependent)


  --cw


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
