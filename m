Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261809AbSJIPKF>; Wed, 9 Oct 2002 11:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261805AbSJIPIw>; Wed, 9 Oct 2002 11:08:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1031 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261804AbSJIPIn>; Wed, 9 Oct 2002 11:08:43 -0400
Date: Wed, 9 Oct 2002 08:16:06 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: Brendan J Simon <brendan.simon@bigpond.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       kbuild-devel <kbuild-devel@lists.sourceforge.net>
Subject: Re: [kbuild-devel] Re: linux kernel conf 0.8
In-Reply-To: <Pine.LNX.4.33L2.0210090730450.1001-100000@dragon.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0210090805250.5862-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 Oct 2002, Randy.Dunlap wrote:
> 
> stick with TCL/TK, like xconfig currently uses ?

Too ugly. I actually think QT is a fine choice, I just suspect that it's 
going to cause political issues.

My favourite approach by far is to actually not ship anything graphical
with the kernel at all, and just hope that the config language syntax is
stable enough that different groups can do their own as external packages.  

The kernel would ship with just the text-based "reference implementation"  
(if even that - we could just have a few "supporting packages").

The only thing I personally really care about is the Config language, 
since that _has_ to ship with the kernel. 

		Linus

PS. And while we're talking about the language - I'd actually prefer the
syntax "depends on" or "requires" instead of "depends", to make it
grammatically more correct. And those help-texts should be separated some
way so that they don't blend in quite as badly with the "command section".
Maybe something really syntactic like just replacing the "help" keyword
with a "---help---"  keyword.

