Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279166AbRKDWPe>; Sun, 4 Nov 2001 17:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279228AbRKDWPY>; Sun, 4 Nov 2001 17:15:24 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:16912 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S279166AbRKDWPL>;
	Sun, 4 Nov 2001 17:15:11 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200111042213.fA4MDoI229389@saturn.cs.uml.edu>
Subject: Re: PROPOSAL: dot-proc interface [was: /proc stuff]
To: jakob@unthought.net (=?iso-8859-1?Q?Jakob_=D8stergaard?=)
Date: Sun, 4 Nov 2001 17:13:50 -0500 (EST)
Cc: acahalan@cs.uml.edu (Albert D. Cahalan),
        linux-kernel@alex.org.uk (Alex Bligh - linux-kernel),
        viro@math.psu.edu (Alexander Viro), moz@compsoc.man.ac.uk (John Levon),
        linux-kernel@vger.kernel.org,
        phillips@bonn-fries.net (Daniel Phillips), tim@tjansen.de (Tim Jansen)
In-Reply-To: <20011104222009.Y14001@unthought.net> from "=?iso-8859-1?Q?Jakob_=D8stergaard?=" at Nov 04, 2001 10:20:09 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=?iso-8859-1?Q?Jak writes:
> On Sun, Nov 04, 2001 at 04:12:23PM -0500, Albert D. Cahalan wrote:

>> You are looking for something called the registry. It's something
>> that was introduced with Windows 95. It's basically a filesystem
>> with typed files: char, int, string, string array, etc.
>
> Nope   :)
>
> It does not have "char, int, string, string array, etc." it
> has "String, binary and DWORD".

I'm pretty sure that newer implementations have additional types.
BTW, we could call the persistent part of our registry "reiserfs4".

> Imagine every field in a file by itself, with well-defined type
> information and unit informaiton.

I suppose I could print a warning if the type or unit info
isn't what was expected. That's insignificantly useful.

Individual files are nice, until you realize: open, read, close

> Performance is one thing.  Not being able to know whether
> numbers are i32, u32, u64, or measured in Kilobytes or
> carrots is another ting.

I don't see what the code is supposed to do if it was expecting
kilobytes and you serve it carrots. Certainly nothing useful can
be done when this happens.
