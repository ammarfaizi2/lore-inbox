Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312146AbSCXXmM>; Sun, 24 Mar 2002 18:42:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312150AbSCXXmD>; Sun, 24 Mar 2002 18:42:03 -0500
Received: from ns.suse.de ([213.95.15.193]:37380 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312146AbSCXXlm>;
	Sun, 24 Mar 2002 18:41:42 -0500
Date: Mon, 25 Mar 2002 00:41:37 +0100
From: Andi Kleen <ak@suse.de>
To: Nick Craig-Wood <ncw@axis.demon.co.uk>
Cc: Andrew Morton <akpm@zip.com.au>, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linus Torvalds <torvalds@transmeta.com>, yodaiken@fsmlabs.com,
        Andi Kleen <ak@suse.de>, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: 10.31 second kernel compile
Message-ID: <20020325004137.A23342@wotan.suse.de>
In-Reply-To: <Pine.LNX.4.33.0203161203050.31971-100000@penguin.transmeta.com> <200203242112.WAA09406@cave.bitwizard.nl> <3C9E46BD.D0BEEB2A@zip.com.au> <20020324225401.A30709@axis.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If there was some hack where 4MB pages could be allocated for
> applications like this then I'd be very happy!

You could always run it as a kernel module.
Just need to add schedule points or use a preemptive kernel. 
When you allocate data using get_free_pages() it'll return a pointer
in the 2 or 4MB mapped direct mapping of the kernel. It'll only work
when your memory is not fragmented. 

-Andi
> 
